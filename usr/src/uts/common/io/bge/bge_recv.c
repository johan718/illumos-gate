/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License, Version 1.0 only
 * (the "License").  You may not use this file except in compliance
 * with the License.
 *
 * You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
 * or http://www.opensolaris.org/os/licensing.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at usr/src/OPENSOLARIS.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */
/*
 * Copyright 2006 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

#pragma ident	"%Z%%M%	%I%	%E% SMI"

#include "sys/bge_impl.h"

#define	U32TOPTR(x)	((void *)(uintptr_t)(uint32_t)(x))
#define	PTRTOU32(x)	((uint32_t)(uintptr_t)(void *)(x))

/*
 * ========== RX side routines ==========
 */

#define	BGE_DBG		BGE_DBG_RECV	/* debug flag for this code	*/

static void bge_refill(bge_t *bgep, buff_ring_t *brp, sw_rbd_t *srbdp);
#pragma	inline(bge_refill)

/*
 * Return the specified buffer (srbdp) to the ring it came from (brp).
 *
 * Note:
 *	If the driver is compiled with only one buffer ring *and* one
 *	return ring, then the buffers must be returned in sequence.
 *	In this case, we don't have to consider anything about the
 *	buffer at all; we can simply advance the cyclic counter.  And
 *	we don't even need the refill mutex <rf_lock>, as the caller
 *	will already be holding the (one-and-only) <rx_lock>.
 *
 *	If the driver supports multiple buffer rings, but only one
 *	return ring, the same still applies (to each buffer ring
 *	separately).
 */
static void
bge_refill(bge_t *bgep, buff_ring_t *brp, sw_rbd_t *srbdp)
{
	uint64_t slot;

	_NOTE(ARGUNUSED(srbdp))

	slot = brp->rf_next;
	brp->rf_next = NEXT(slot, brp->desc.nslots);
	bge_mbx_put(bgep, brp->chip_mbx_reg, slot);
}

static mblk_t *bge_receive_packet(bge_t *bgep, bge_rbd_t *hw_rbd_p);
#pragma	inline(bge_receive_packet)

static mblk_t *
bge_receive_packet(bge_t *bgep, bge_rbd_t *hw_rbd_p)
{
	bge_rbd_t hw_rbd;
	buff_ring_t *brp;
	sw_rbd_t *srbdp;
	uchar_t *dp;
	mblk_t *mp;
	uint_t len;
	uint_t minsize;
	uint_t maxsize;
	uint32_t pflags;

	mp = NULL;
	hw_rbd = *hw_rbd_p;

	switch (hw_rbd.flags & (RBD_FLAG_MINI_RING|RBD_FLAG_JUMBO_RING)) {
	case RBD_FLAG_MINI_RING|RBD_FLAG_JUMBO_RING:
	default:
		/* error, this shouldn't happen */
		BGE_PKTDUMP((bgep, &hw_rbd, NULL, "bad ring flags!"));
		goto error;

	case RBD_FLAG_JUMBO_RING:
		brp = &bgep->buff[BGE_JUMBO_BUFF_RING];
		break;

#if	(BGE_BUFF_RINGS_USED > 2)
	case RBD_FLAG_MINI_RING:
		brp = &bgep->buff[BGE_MINI_BUFF_RING];
		break;
#endif	/* BGE_BUFF_RINGS_USED > 2 */

	case 0:
		brp = &bgep->buff[BGE_STD_BUFF_RING];
		break;
	}

	if (hw_rbd.index >= brp->desc.nslots) {
		/* error, this shouldn't happen */
		BGE_PKTDUMP((bgep, &hw_rbd, NULL, "bad ring index!"));
		goto error;
	}

	srbdp = &brp->sw_rbds[hw_rbd.index];
	if (hw_rbd.opaque != srbdp->pbuf.token) {
		/* bogus, drop the packet */
		BGE_PKTDUMP((bgep, &hw_rbd, srbdp, "bad ring token"));
		goto refill;
	}

	if ((hw_rbd.flags & RBD_FLAG_PACKET_END) == 0) {
		/* bogus, drop the packet */
		BGE_PKTDUMP((bgep, &hw_rbd, srbdp, "unterminated packet"));
		goto refill;
	}

	if (hw_rbd.flags & RBD_FLAG_FRAME_HAS_ERROR) {
		/* bogus, drop the packet */
		BGE_PKTDUMP((bgep, &hw_rbd, srbdp, "errored packet"));
		goto refill;
	}

	len = hw_rbd.len;

#ifdef ASF_SUPPORT
	/*
	 * When IPMI/ASF is enalbed, VLAN tag must be stripped.
	 */
	if ((bgep->asf_flags == ASF_ENABLED) &&
		(hw_rbd.flags & RBD_FLAG_VLAN_TAG)) {
		maxsize = bgep->chipid.ethmax_size + ETHERFCSL;
	} else
#endif
		/*
		 * H/W will not strip the VLAN tag from incoming packet
		 * now, as RECEIVE_MODE_KEEP_VLAN_TAG bit is set in
		 * RECEIVE_MAC_MODE_REG register.
		 */
		maxsize = bgep->chipid.ethmax_size + VLAN_TAGSZ + ETHERFCSL;
	if (len > maxsize) {
		/* bogus, drop the packet */
		BGE_PKTDUMP((bgep, &hw_rbd, srbdp, "oversize packet"));
		goto refill;
	}

#ifdef ASF_SUPPORT
	if ((bgep->asf_flags == ASF_ENABLED) &&
		(hw_rbd.flags & RBD_FLAG_VLAN_TAG)) {
		minsize = ETHERMIN + ETHERFCSL - VLAN_TAGSZ;
	} else
#endif
		minsize = ETHERMIN + ETHERFCSL;
	if (len < minsize) {
		/* bogus, drop the packet */
		BGE_PKTDUMP((bgep, &hw_rbd, srbdp, "undersize packet"));
		goto refill;
	}

	/*
	 * Packet looks good; get a buffer to copy it into.
	 * We want to leave some space at the front of the allocated
	 * buffer in case any upstream modules want to prepend some
	 * sort of header.  This also has the side-effect of making
	 * the packet *contents* 4-byte aligned, as required by NCA!
	 */
#ifdef ASF_SUPPORT
	if ((bgep->asf_flags == ASF_ENABLED) &&
		(hw_rbd.flags & RBD_FLAG_VLAN_TAG)) {
		mp = allocb(BGE_HEADROOM + len + VLAN_TAGSZ, 0);
	} else {
#endif

		mp = allocb(BGE_HEADROOM + len, 0);
#ifdef ASF_SUPPORT
	}
#endif
	if (mp == NULL) {
		/* Nothing to do but drop the packet */
		goto refill;
	}

	/*
	 * Sync the data and copy it to the STREAMS buffer.
	 */
	DMA_SYNC(srbdp->pbuf, DDI_DMA_SYNC_FORKERNEL);
#ifdef ASF_SUPPORT
	if ((bgep->asf_flags == ASF_ENABLED) &&
		(hw_rbd.flags & RBD_FLAG_VLAN_TAG)) {

		/*
		 * As VLAN tag has been stripped from incoming packet in ASF
		 * scenario, we insert it into this packet again.
		 */
		struct ether_vlan_header *ehp;
		mp->b_rptr = dp = mp->b_rptr + BGE_HEADROOM - VLAN_TAGSZ;
		bcopy(DMA_VPTR(srbdp->pbuf), dp, 2 * ETHERADDRL);
		ehp = (struct ether_vlan_header *)dp;
		ehp->ether_tpid = ntohs(VLAN_TPID);
		ehp->ether_tci = ntohs(hw_rbd.vlan_tci);
		bcopy(((uchar_t *)(DMA_VPTR(srbdp->pbuf))) + 2 * ETHERADDRL,
			dp + 2 * ETHERADDRL + VLAN_TAGSZ,
			len - 2 * ETHERADDRL);
	} else {
#endif
		mp->b_rptr = dp = mp->b_rptr + BGE_HEADROOM;
		bcopy(DMA_VPTR(srbdp->pbuf), dp, len);
#ifdef ASF_SUPPORT
	}

	if ((bgep->asf_flags == ASF_ENABLED) &&
		(hw_rbd.flags & RBD_FLAG_VLAN_TAG)) {
		mp->b_wptr = dp + len + VLAN_TAGSZ - ETHERFCSL;
	} else
#endif
		mp->b_wptr = dp + len - ETHERFCSL;

	/*
	 * Special check for one specific type of data corruption;
	 * in a good packet, the first 8 bytes are *very* unlikely
	 * to be the same as the second 8 bytes ... but we let the
	 * packet through just in case.
	 */
	if (bcmp(dp, dp+8, 8) == 0)
		BGE_PKTDUMP((bgep, &hw_rbd, srbdp, "stuttered packet?"));

	pflags = 0;
	if (hw_rbd.flags & RBD_FLAG_TCP_UDP_CHECKSUM)
		pflags |= HCK_FULLCKSUM;
	if (hw_rbd.flags & RBD_FLAG_IP_CHECKSUM)
		pflags |= HCK_IPV4_HDRCKSUM;
	if (pflags != 0)
		(void) hcksum_assoc(mp, NULL, NULL, 0, 0, 0,
		    hw_rbd.tcp_udp_cksum, pflags, 0);

refill:
	/*
	 * Replace the buffer in the ring it came from ...
	 */
	bge_refill(bgep, brp, srbdp);
	return (mp);

error:
	/*
	 * We come here if the integrity of the ring descriptors
	 * (rather than merely packet data) appears corrupted.
	 * The factotum will attempt to reset-and-recover.
	 */
	mutex_enter(bgep->genlock);
	bgep->bge_chip_state = BGE_CHIP_ERROR;
	mutex_exit(bgep->genlock);
	return (NULL);
}

/*
 * Accept the packets received in the specified ring up to
 * (but not including) the producer index in the status block.
 *
 * Returns a chain of mblks containing the received data, to be
 * passed up to gld_recv() (we can't call gld_recv() from here,
 * 'cos we're holding the per-ring receive lock at this point).
 *
 * This function must advance (rrp->rx_next) and write it back to
 * the chip to indicate the packets it has accepted from the ring.
 */
static mblk_t *bge_receive_ring(bge_t *bgep, recv_ring_t *rrp);
#pragma	inline(bge_receive_ring)

static mblk_t *
bge_receive_ring(bge_t *bgep, recv_ring_t *rrp)
{
	bge_rbd_t *hw_rbd_p;
	uint64_t slot;
	mblk_t *head;
	mblk_t **tail;
	mblk_t *mp;

	ASSERT(mutex_owned(rrp->rx_lock));

	/*
	 * Sync (all) the receive ring descriptors
	 * before accepting the packets they describe
	 */
	DMA_SYNC(rrp->desc, DDI_DMA_SYNC_FORKERNEL);
	hw_rbd_p = DMA_VPTR(rrp->desc);
	head = NULL;
	tail = &head;
	slot = rrp->rx_next;

	while (slot != *rrp->prod_index_p) {	/* Note: volatile	*/
		if ((mp = bge_receive_packet(bgep, &hw_rbd_p[slot])) != NULL) {
			*tail = mp;
			tail = &mp->b_next;
		}
		rrp->rx_next = slot = NEXT(slot, rrp->desc.nslots);
	}

	bge_mbx_put(bgep, rrp->chip_mbx_reg, rrp->rx_next);
	return (head);
}

/*
 * Receive all packets in all rings.
 *
 * To give priority to low-numbered rings, whenever we have received any
 * packets in any ring except 0, we restart scanning again from ring 0.
 * Thus, for example, if rings 0, 3, and 10 are carrying traffic, the
 * pattern of receives might go 0, 3, 10, 3, 0, 10, 0:
 *
 *	0	found some - receive them
 *	1..2					none found
 *	3	found some - receive them	and restart scan
 *	0..9					none found
 *	10	found some - receive them	and restart scan
 *	0..2					none found
 *	3	found some more - receive them	and restart scan
 *	0	found some more - receive them
 *	1..9					none found
 *	10	found some more - receive them	and restart scan
 *	0	found some more - receive them
 *	1..15					none found
 *
 * The routine returns only when a complete scan has been performed
 * without finding any packets to receive.
 *
 * Note that driver-defined locks may *NOT* be held across calls
 * to gld_recv().
 *
 * Note: the expression (BGE_RECV_RINGS_USED > 1), yields a compile-time
 * constant and allows the compiler to optimise away the outer do-loop
 * if only one receive ring is being used.
 */
void bge_receive(bge_t *bgep, bge_status_t *bsp);
#pragma	no_inline(bge_receive)

void
bge_receive(bge_t *bgep, bge_status_t *bsp)
{
	recv_ring_t *rrp;
	uint64_t ring;
	uint64_t rx_rings = bgep->chipid.rx_rings;
	mblk_t *mp;

restart:
	ring = 0;
	rrp = &bgep->recv[ring];
	do {
		/*
		 * For each ring, (rrp->prod_index_p) points to the
		 * proper index within the status block (which has
		 * already been sync'd by the caller)
		 */
		ASSERT(rrp->prod_index_p == RECV_INDEX_P(bsp, ring));

		if (*rrp->prod_index_p == rrp->rx_next)
			continue;		/* no packets		*/
		if (mutex_tryenter(rrp->rx_lock) == 0)
			continue;		/* already in process	*/
		mp = bge_receive_ring(bgep, rrp);
		mutex_exit(rrp->rx_lock);

		if (mp != NULL) {
			mac_rx(bgep->macp, rrp->handle, mp);

			/*
			 * Restart from ring 0, if the driver is compiled
			 * with multiple rings and we're not on ring 0 now
			 */
			if (rx_rings > 1 && ring > 0)
				goto restart;
		}

		/*
		 * Loop over all rings (if there *are* multiple rings)
		 */
	} while (++rrp, ++ring < rx_rings);
}
