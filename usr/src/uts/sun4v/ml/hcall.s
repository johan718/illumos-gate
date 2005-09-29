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
 * Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

#pragma ident	"%Z%%M%	%I%	%E% SMI"

/*
 * Hypervisor calls
 */

#include <sys/asm_linkage.h>
#include <sys/machasi.h>
#include <sys/machparam.h>
#include <sys/hypervisor_api.h>
#include <io/px/px_ioapi.h>

#if defined(lint) || defined(__lint)

/*ARGSUSED*/
int64_t
hv_cnputchar(uint8_t ch)
{ return (0); }

/*ARGSUSED*/
int64_t
hv_cngetchar(uint8_t *ch)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_tod_get(uint64_t *seconds)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_tod_set(uint64_t seconds)
{ return (0);}

/*ARGSUSED*/
uint64_t
hv_mmu_map_perm_addr(void *vaddr, int ctx, uint64_t tte, int flags)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_mmu_unmap_perm_addr(void *vaddr, int ctx, int flags)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_set_ctx0(uint64_t ntsb_descriptor, uint64_t desc_ra)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_set_ctxnon0(uint64_t ntsb_descriptor, uint64_t desc_ra)
{ return (0); }

#ifdef SET_MMU_STATS
/*ARGSUSED*/
uint64_t
hv_mmu_set_stat_area(uint64_t rstatarea, uint64_t size)
{ return (0); }
#endif /* SET_MMU_STATS */

/*ARGSUSED*/
uint64_t
hv_cpu_qconf(int queue, uint64_t paddr, int size)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_config_get(devhandle_t dev_hdl, pci_device_t bdf,
    pci_config_offset_t off, pci_config_size_t size, pci_cfg_data_t *data_p)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_config_put(devhandle_t dev_hdl, pci_device_t bdf,
    pci_config_offset_t off, pci_config_size_t size, pci_cfg_data_t data)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_intr_devino_to_sysino(uint64_t dev_hdl, uint32_t devino, uint64_t *sysino)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_intr_getvalid(uint64_t sysino, int *intr_valid_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_intr_setvalid(uint64_t sysino, int intr_valid_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_intr_getstate(uint64_t sysino, int *intr_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_intr_setstate(uint64_t sysino, int intr_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_intr_gettarget(uint64_t sysino, uint32_t *cpuid)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_intr_settarget(uint64_t sysino, uint32_t cpuid)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_iommu_map(devhandle_t dev_hdl, tsbid_t tsbid,
    pages_t pages, io_attributes_t io_attributes,
    io_page_list_t *io_page_list_p, pages_t *pages_mapped)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_iommu_demap(devhandle_t dev_hdl, tsbid_t tsbid,
    pages_t pages, pages_t *pages_demapped)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_iommu_getmap(devhandle_t dev_hdl, tsbid_t tsbid,
    io_attributes_t *attributes_p, r_addr_t *r_addr_p)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_iommu_getbypass(devhandle_t dev_hdl, r_addr_t ra,
    io_attributes_t io_attributes, io_addr_t *io_addr_p)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_peek(devhandle_t dev_hdl, r_addr_t ra, size_t size, uint32_t *status,
    uint64_t *data_p)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_poke(devhandle_t dev_hdl, r_addr_t ra, uint64_t sizes, uint64_t data,
    r_addr_t ra2, uint32_t *rdbk_status)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_dma_sync(devhandle_t dev_hdl, r_addr_t ra, size_t num_bytes,
    int io_sync_direction, size_t *bytes_synched)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msiq_conf(devhandle_t dev_hdl, msiqid_t msiq_id, r_addr_t ra,
    uint_t msiq_rec_cnt)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msiq_info(devhandle_t dev_hdl, msiqid_t msiq_id, r_addr_t *r_addr_p,
    uint_t *msiq_rec_cnt_p)
{ return (0); }
	
/*ARGSUSED*/
uint64_t
hvio_msiq_getvalid(devhandle_t dev_hdl, msiqid_t msiq_id,
    pci_msiq_valid_state_t *msiq_valid_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msiq_setvalid(devhandle_t dev_hdl, msiqid_t msiq_id,
    pci_msiq_valid_state_t msiq_valid_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msiq_getstate(devhandle_t dev_hdl, msiqid_t msiq_id,
    pci_msiq_state_t *msiq_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msiq_setstate(devhandle_t dev_hdl, msiqid_t msiq_id,
    pci_msiq_state_t msiq_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msiq_gethead(devhandle_t dev_hdl, msiqid_t msiq_id,
    msiqhead_t *msiq_head)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msiq_sethead(devhandle_t dev_hdl, msiqid_t msiq_id,
    msiqhead_t msiq_head)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msiq_gettail(devhandle_t dev_hdl, msiqid_t msiq_id,
    msiqtail_t *msiq_tail)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msi_getmsiq(devhandle_t dev_hdl, msinum_t msi_num,
    msiqid_t *msiq_id)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msi_setmsiq(devhandle_t dev_hdl, msinum_t msi_num,
    msiqid_t msiq_id, msi_type_t msitype)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msi_getvalid(devhandle_t dev_hdl, msinum_t msi_num,
    pci_msi_valid_state_t *msi_valid_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msi_setvalid(devhandle_t dev_hdl, msinum_t msi_num,
    pci_msi_valid_state_t msi_valid_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msi_getstate(devhandle_t dev_hdl, msinum_t msi_num,
    pci_msi_state_t *msi_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msi_setstate(devhandle_t dev_hdl, msinum_t msi_num,
    pci_msi_state_t msi_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msg_getmsiq(devhandle_t dev_hdl, pcie_msg_type_t msg_type,
    msiqid_t *msiq_id)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msg_setmsiq(devhandle_t dev_hdl, pcie_msg_type_t msg_type,
    msiqid_t msiq_id)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msg_getvalid(devhandle_t dev_hdl, pcie_msg_type_t msg_type,
    pcie_msg_valid_state_t *msg_valid_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hvio_msg_setvalid(devhandle_t dev_hdl, pcie_msg_type_t msg_type,
    pcie_msg_valid_state_t msg_valid_state)
{ return (0); }

uint64_t
hv_cpu_yield(void)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_service_recv(uint64_t s_id, uint64_t buf_pa, uint64_t size,
    uint64_t *recv_bytes)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_service_send(uint64_t s_id, uint64_t buf_pa, uint64_t size,
    uint64_t *send_bytes)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_service_getstatus(uint64_t s_id, uint64_t *vreg)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_service_setstatus(uint64_t s_id, uint64_t bits)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_service_clrstatus(uint64_t s_id, uint64_t bits)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_cpu_state(uint64_t cpuid, uint64_t *cpu_state)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_dump_buf_update(uint64_t paddr, uint64_t size, uint64_t *minsize)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_mem_scrub(uint64_t real_addr, uint64_t length, uint64_t *scrubbed_len)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_mem_sync(uint64_t real_addr, uint64_t length, uint64_t *flushed_len)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_ttrace_buf_conf(uint64_t paddr, uint64_t size, uint64_t *size1)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_ttrace_buf_info(uint64_t *paddr, uint64_t *size)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_ttrace_enable(uint64_t enable, uint64_t *prev_enable)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_ttrace_freeze(uint64_t freeze, uint64_t *prev_freeze)
{ return (0); }

/*ARGSUSED*/
uint64_t
hv_mach_desc(uint64_t buffer_ra, uint64_t *buffer_sizep)
{ return (0); }
	
/*ARGSUSED*/	
uint64_t
hv_ncs_request(int cmd, uint64_t realaddr, size_t sz)
{ return (0); }

/*ARGSUSED*/	
uint64_t
hv_ra2pa(uint64_t ra)
{ return (0); }

/*ARGSUSED*/	
uint64_t
hv_hpriv(void *func, uint64_t arg1, uint64_t arg2, uint64_t arg3)
{ return (0); }

#else	/* lint || __lint */

	/*
	 * %o0 - character
	 */
	ENTRY(hv_cnputchar)
	mov	CONS_WRITE, %o5
	ta	FAST_TRAP
	tst	%o0
	retl
	movnz	%xcc, -1, %o0
	SET_SIZE(hv_cnputchar)

	/*
	 * %o0 pointer to character buffer
	 * return values:
	 * 0 success
	 * hv_errno failure
	 */
	ENTRY(hv_cngetchar)
	mov	%o0, %o2
	mov	CONS_READ, %o5
	ta	FAST_TRAP
	brnz,a	%o0, 1f		! failure, just return error
	mov	1, %o0

	cmp	%o1, H_BREAK
	be	1f
	mov	%o1, %o0

	cmp	%o1, H_HUP
	be	1f
	mov	%o1, %o0

	stb	%o1, [%o2]	! success, save character and return 0
	mov	0, %o0
1:
	retl
	nop
	SET_SIZE(hv_cngetchar)

	ENTRY(hv_tod_get)
	mov	%o0, %o4
	mov	TOD_GET, %o5
	ta	FAST_TRAP
	retl
	  stx	%o1, [%o4] 
	SET_SIZE(hv_tod_get)

	ENTRY(hv_tod_set)
	mov	TOD_SET, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_tod_set)

	/*
	 * Map permanent address
	 * arg0 vaddr (%o0)
	 * arg1 context (%o1)
	 * arg2 tte (%o2)
	 * arg3 flags (%o3)  0x1=d 0x2=i
	 */
	ENTRY(hv_mmu_map_perm_addr)
	mov	MAP_PERM_ADDR, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_mmu_map_perm_addr)

	/*
	 * Unmap permanent address
	 * arg0 vaddr (%o0)
	 * arg1 context (%o1)
	 * arg2 flags (%o2)  0x1=d 0x2=i
	 */
	ENTRY(hv_mmu_unmap_perm_addr)
	mov	UNMAP_PERM_ADDR, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_mmu_unmap_perm_addr)

	/*
	 * Set TSB for context 0
	 * arg0 ntsb_descriptor (%o0)
	 * arg1 desc_ra (%o1)
	 */
	ENTRY(hv_set_ctx0)
	mov	MMU_TSB_CTX0, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_set_ctx0)

	/*
	 * Set TSB for context non0
	 * arg0 ntsb_descriptor (%o0)
	 * arg1 desc_ra (%o1)
	 */
	ENTRY(hv_set_ctxnon0)
	mov	MMU_TSB_CTXNON0, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_set_ctxnon0)

#ifdef SET_MMU_STATS
	/*
	 * Returns old stat area on success
	 */
	ENTRY(hv_mmu_set_stat_area)
	mov	MMU_STAT_AREA, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_mmu_set_stat_area)
#endif /* SET_MMU_STATS */

	/*
	 * CPU Q Configure
	 * arg0 queue (%o0)
	 * arg1 Base address RA (%o1)
	 * arg2 Size (%o2)
	 */
	ENTRY(hv_cpu_qconf)
	mov	CPU_QCONF, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_cpu_qconf)

	/*
	 * arg0 - devhandle
	 * arg1 - pci_device
	 * arg2 - pci_config_offset
	 * arg3 - pci_config_size
	 *
	 * ret0 - status
	 * ret1 - error_flag
	 * ret2 - pci_cfg_data
	 */
	ENTRY(hvio_config_get)
	mov	HVIO_CONFIG_GET, %o5
	ta	FAST_TRAP
	brnz	%o0, 1f
	movrnz	%o1, -1, %o2
	brz,a	%o1, 1f
	stuw	%o2, [%o4]
1:	retl
	nop
	SET_SIZE(hvio_config_get)

	/*
	 * arg0 - devhandle
	 * arg1 - pci_device
	 * arg2 - pci_config_offset
	 * arg3 - pci_config_size
	 * arg4 - pci_cfg_data
	 *
	 * ret0 - status
	 * ret1 - error_flag
	 */
	ENTRY(hvio_config_put)
	mov	HVIO_CONFIG_PUT, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_config_put)

	/*
	 * arg0 - devhandle
	 * arg1 - devino
	 *
	 * ret0 - status
	 * ret1 - sysino
	 */
	ENTRY(hvio_intr_devino_to_sysino)
	mov	HVIO_INTR_DEVINO2SYSINO, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stx	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_intr_devino_to_sysino)

	/*
	 * arg0 - sysino
	 *
	 * ret0 - status
	 * ret1 - intr_valid_state
	 */
	ENTRY(hvio_intr_getvalid)
	mov	%o1, %o2
	mov	HVIO_INTR_GETVALID, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_intr_getvalid)

	/*
	 * arg0 - sysino
	 * arg1 - intr_valid_state
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_intr_setvalid)
	mov	HVIO_INTR_SETVALID, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_intr_setvalid)

	/*
	 * arg0 - sysino
	 *
	 * ret0 - status
	 * ret1 - intr_state
	 */
	ENTRY(hvio_intr_getstate)
	mov	%o1, %o2
	mov	HVIO_INTR_GETSTATE, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_intr_getstate)

	/*
	 * arg0 - sysino
	 * arg1 - intr_state
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_intr_setstate)
	mov	HVIO_INTR_SETSTATE, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_intr_setstate)

	/*
	 * arg0 - sysino
	 *
	 * ret0 - status
	 * ret1 - cpu_id
	 */
	ENTRY(hvio_intr_gettarget)
	mov	%o1, %o2
	mov	HVIO_INTR_GETTARGET, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_intr_gettarget)

	/*
	 * arg0 - sysino
	 * arg1 - cpu_id
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_intr_settarget)
	mov	HVIO_INTR_SETTARGET, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_intr_settarget)

	/*
	 * arg0 - devhandle
	 * arg1 - tsbid
	 * arg2 - pages
	 * arg3 - io_attributes
	 * arg4 - io_page_list_p
	 *
	 * ret1 - pages_mapped
	 */
	ENTRY(hvio_iommu_map)
	save	%sp, -SA(MINFRAME64), %sp
	mov	%i0, %o0
	mov	%i1, %o1
	mov	%i2, %o2
	mov	%i3, %o3
	mov	%i4, %o4
	mov	HVIO_IOMMU_MAP, %o5
	ta	FAST_TRAP
	brnz	%o0, 1f
	mov	%o0, %i0
	stuw	%o1, [%i5]
1:
	ret
	restore
	SET_SIZE(hvio_iommu_map)

	/*
	 * arg0 - devhandle
	 * arg1 - tsbid
	 * arg2 - pages
	 *
	 * ret1 - pages_demapped
	 */
	ENTRY(hvio_iommu_demap)
	mov	HVIO_IOMMU_DEMAP, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o3]
1:	retl
	nop
	SET_SIZE(hvio_iommu_demap)

	/*
	 * arg0 - devhandle
	 * arg1 - tsbid
	 *
	 *
	 * ret0 - status
	 * ret1 - io_attributes
	 * ret2 - r_addr
	 */
	ENTRY(hvio_iommu_getmap)
	mov	%o2, %o4
	mov	HVIO_IOMMU_GETMAP, %o5
	ta	FAST_TRAP
	brnz	%o0, 1f
	nop
	stx	%o2, [%o3]
	st	%o1, [%o4]
1:
	retl
	nop
	SET_SIZE(hvio_iommu_getmap)

	/*
	 * arg0 - devhandle
	 * arg1 - r_addr
	 * arg2 - io_attributes
	 *
	 *
	 * ret0 - status
	 * ret1 - io_addr
	 */
	ENTRY(hvio_iommu_getbypass)
	mov	HVIO_IOMMU_GETBYPASS, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stx	%o1, [%o3]
1:	retl
	nop
	SET_SIZE(hvio_iommu_getbypass)

	/*
	 * arg0 - devhandle
	 * arg1 - r_addr
	 * arg2 - size
	 *
	 * ret1 - error_flag
	 * ret2 - data
	 */
	ENTRY(hvio_peek)
	mov	HVIO_PEEK, %o5
	ta	FAST_TRAP
	brnz	%o0, 1f
	nop
	stx	%o2, [%o4]
	st	%o1, [%o3]
1:
	retl
	nop
	SET_SIZE(hvio_peek)

	/*
	 * arg0 - devhandle
	 * arg1 - r_addr
	 * arg2 - sizes
	 * arg3 - data
	 * arg4 - r_addr2
	 *
	 * ret1 - error_flag
	 */
	ENTRY(hvio_poke)
	save	%sp, -SA(MINFRAME64), %sp
	mov	%i0, %o0
	mov	%i1, %o1
	mov	%i2, %o2
	mov	%i3, %o3
	mov	%i4, %o4
	mov	HVIO_POKE, %o5
	ta	FAST_TRAP
	brnz	%o0, 1f
	mov	%o0, %i0
	stuw	%o1, [%i5]
1:
	ret
	restore
	SET_SIZE(hvio_poke)

	/*
	 * arg0 - devhandle
	 * arg1 - r_addr
	 * arg2 - num_bytes
	 * arg3 - io_sync_direction
	 *
	 * ret0 - status
	 * ret1 - bytes_synched
	 */
	ENTRY(hvio_dma_sync)
	mov	HVIO_DMA_SYNC, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stx	%o1, [%o4]
1:	retl
	nop
	SET_SIZE(hvio_dma_sync)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 * arg2 - r_addr
	 * arg3 - nentries
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msiq_conf)
	mov	HVIO_MSIQ_CONF, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msiq_conf)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 *
	 * ret0 - status
	 * ret1 - r_addr
	 * ret1 - nentries
	 */
	ENTRY(hvio_msiq_info)
	mov     %o2, %o4
	mov     HVIO_MSIQ_INFO, %o5
	ta      FAST_TRAP
	brnz    1f
	nop
	stx     %o1, [%o4]
	stuw    %o2, [%o3]
1:      retl
	nop
	SET_SIZE(hvio_msiq_info)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 *
	 * ret0 - status
	 * ret1 - msiq_valid_state
	 */
	ENTRY(hvio_msiq_getvalid)
	mov	HVIO_MSIQ_GETVALID, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msiq_getvalid)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 * arg2 - msiq_valid_state
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msiq_setvalid)
	mov	HVIO_MSIQ_SETVALID, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msiq_setvalid)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 *
	 * ret0 - status
	 * ret1 - msiq_state
	 */
	ENTRY(hvio_msiq_getstate)
	mov	HVIO_MSIQ_GETSTATE, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msiq_getstate)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 * arg2 - msiq_state
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msiq_setstate)
	mov	HVIO_MSIQ_SETSTATE, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msiq_setstate)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 *
	 * ret0 - status
	 * ret1 - msiq_head
	 */
	ENTRY(hvio_msiq_gethead)
	mov	HVIO_MSIQ_GETHEAD, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stx	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msiq_gethead)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 * arg2 - msiq_head
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msiq_sethead)
	mov	HVIO_MSIQ_SETHEAD, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msiq_sethead)

	/*
	 * arg0 - devhandle
	 * arg1 - msiq_id
	 *
	 * ret0 - status
	 * ret1 - msiq_tail
	 */
	ENTRY(hvio_msiq_gettail)
	mov	HVIO_MSIQ_GETTAIL, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stx	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msiq_gettail)

	/*
	 * arg0 - devhandle
	 * arg1 - msi_num
	 *
	 * ret0 - status
	 * ret1 - msiq_id
	 */
	ENTRY(hvio_msi_getmsiq)
	mov	HVIO_MSI_GETMSIQ, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msi_getmsiq)

	/*
	 * arg0 - devhandle
	 * arg1 - msi_num
	 * arg2 - msiq_id
	 * arg2 - msitype
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msi_setmsiq)
	mov	HVIO_MSI_SETMSIQ, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msi_setmsiq)

	/*
	 * arg0 - devhandle
	 * arg1 - msi_num
	 *
	 * ret0 - status
	 * ret1 - msi_valid_state
	 */
	ENTRY(hvio_msi_getvalid)
	mov	HVIO_MSI_GETVALID, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msi_getvalid)

	/*
	 * arg0 - devhandle
	 * arg1 - msi_num
	 * arg2 - msi_valid_state
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msi_setvalid)
	mov	HVIO_MSI_SETVALID, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msi_setvalid)

	/*
	 * arg0 - devhandle
	 * arg1 - msi_num
	 *
	 * ret0 - status
	 * ret1 - msi_state
	 */
	ENTRY(hvio_msi_getstate)
	mov	HVIO_MSI_GETSTATE, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msi_getstate)

	/*
	 * arg0 - devhandle
	 * arg1 - msi_num
	 * arg2 - msi_state
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msi_setstate)
	mov	HVIO_MSI_SETSTATE, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msi_setstate)

	/*
	 * arg0 - devhandle
	 * arg1 - msg_type
	 *
	 * ret0 - status
	 * ret1 - msiq_id
	 */
	ENTRY(hvio_msg_getmsiq)
	mov	HVIO_MSG_GETMSIQ, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msg_getmsiq)

	/*
	 * arg0 - devhandle
	 * arg1 - msg_type
	 * arg2 - msiq_id
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msg_setmsiq)
	mov	HVIO_MSG_SETMSIQ, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msg_setmsiq)

	/*
	 * arg0 - devhandle
	 * arg1 - msg_type
	 *
	 * ret0 - status
	 * ret1 - msg_valid_state
	 */
	ENTRY(hvio_msg_getvalid)
	mov	HVIO_MSG_GETVALID, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stuw	%o1, [%o2]
1:	retl
	nop
	SET_SIZE(hvio_msg_getvalid)

	/*
	 * arg0 - devhandle
	 * arg1 - msg_type
	 * arg2 - msg_valid_state
	 *
	 * ret0 - status
	 */
	ENTRY(hvio_msg_setvalid)
	mov	HVIO_MSG_SETVALID, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hvio_msg_setvalid)

	/*
	 * hv_cpu_yield(void)
	 */
	ENTRY(hv_cpu_yield)
	mov	HV_CPU_YIELD, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_cpu_yield)

	/*
	 * hv_service_recv(uint64_t s_id, uint64_t buf_pa,
	 *     uint64_t size, uint64_t *recv_bytes);
	 */
	ENTRY(hv_service_recv)
	save	%sp, -SA(MINFRAME), %sp
	mov	%i0, %o0
	mov	%i1, %o1
	mov	%i2, %o2
	mov	%i3, %o3
	mov	SVC_RECV, %o5
	ta	FAST_TRAP
	brnz	%o0, 1f
	mov	%o0, %i0
	stx	%o1, [%i3]
1:
	ret
	restore
	SET_SIZE(hv_service_recv)

	/*
	 * hv_service_send(uint64_t s_id, uint64_t buf_pa,
	 *     uint64_t size, uint64_t *recv_bytes);
	 */
	ENTRY(hv_service_send)
	save	%sp, -SA(MINFRAME), %sp
	mov	%i0, %o0
	mov	%i1, %o1
	mov	%i2, %o2
	mov	%i3, %o3
	mov	SVC_SEND, %o5
	ta	FAST_TRAP
	brnz	%o0, 1f
	mov	%o0, %i0
	stx	%o1, [%i3]
1:
	ret
	restore	
	SET_SIZE(hv_service_send)
	
	/*
	 * hv_service_getstatus(uint64_t s_id, uint64_t *vreg);
	 */
	ENTRY(hv_service_getstatus)
	mov	%o1, %o4			! save datap
	mov	SVC_GETSTATUS, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stx	%o1, [%o4]
1:
	retl
	nop
	SET_SIZE(hv_service_getstatus)
	
	/*
	 * hv_service_setstatus(uint64_t s_id, uint64_t bits);
	 */
	ENTRY(hv_service_setstatus)
	mov	SVC_SETSTATUS, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_service_setstatus)

	/*
	 * hv_service_clrstatus(uint64_t s_id, uint64_t bits);
	 */
	ENTRY(hv_service_clrstatus)
	mov	SVC_CLRSTATUS, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_service_clrstatus)

	/*
	 * int hv_cpu_state(uint64_t cpuid, uint64_t *cpu_state);
	 */
	ENTRY(hv_cpu_state)
	mov	%o1, %o4			! save datap
	mov	HV_CPU_STATE, %o5
	ta	FAST_TRAP
	brz,a	%o0, 1f
	stx	%o1, [%o4]
1:
	retl
	nop
	SET_SIZE(hv_cpu_state)

	/*
	 * HV state dump zone Configure
	 * arg0 real adrs of dump buffer (%o0)
	 * arg1 size of dump buffer (%o1)
	 * ret0 status (%o0)
	 * ret1 size of buffer on success and min size on EINVAL (%o1)
	 * hv_dump_buf_update(uint64_t paddr, uint64_t size, uint64_t *ret_size)
	 */
	ENTRY(hv_dump_buf_update)
	mov	DUMP_BUF_UPDATE, %o5
	ta	FAST_TRAP
	retl
	stx	%o1, [%o2]
	SET_SIZE(hv_dump_buf_update)


	/*
	 * For memory scrub
	 * int hv_mem_scrub(uint64_t real_addr, uint64_t length,
	 * 	uint64_t *scrubbed_len);
	 * Retun %o0 -- status
	 *       %o1 -- bytes scrubbed
	 */
	ENTRY(hv_mem_scrub)
	mov	%o2, %o4
	mov	HV_MEM_SCRUB, %o5
	ta	FAST_TRAP
	retl
	stx	%o1, [%o4]
	SET_SIZE(hv_mem_scrub)

	/*
	 * Flush ecache 
	 * int hv_mem_sync(uint64_t real_addr, uint64_t length,
	 * 	uint64_t *flushed_len);
	 * Retun %o0 -- status
	 *       %o1 -- bytes flushed
	 */
	ENTRY(hv_mem_sync)
	mov	%o2, %o4
	mov	HV_MEM_SYNC, %o5
	ta	FAST_TRAP
	retl
	stx	%o1, [%o4]
	SET_SIZE(hv_mem_sync)

	/*
	 * TTRACE_BUF_CONF Configure
	 * arg0 RA base of buffer (%o0)
	 * arg1 buf size in no. of entries (%o1)
	 * ret0 status (%o0)
	 * ret1 minimum size in no. of entries on failure,
	 * actual size in no. of entries on success (%o1)
	 */
	ENTRY(hv_ttrace_buf_conf)
	mov	TTRACE_BUF_CONF, %o5
	ta	FAST_TRAP
	retl
	stx	%o1, [%o2]
	SET_SIZE(hv_ttrace_buf_conf)

	 /*
	 * TTRACE_BUF_INFO
	 * ret0 status (%o0)
	 * ret1 RA base of buffer (%o1)
	 * ret2 size in no. of entries (%o2)
	 */
	ENTRY(hv_ttrace_buf_info)
	mov	%o0, %o3
	mov	%o1, %o4
	mov	TTRACE_BUF_INFO, %o5
	ta	FAST_TRAP
	stx	%o1, [%o3]
	retl
	stx	%o2, [%o4]
	SET_SIZE(hv_ttrace_buf_info)

	/*
	 * TTRACE_ENABLE
	 * arg0 enable/ disable (%o0)
	 * ret0 status (%o0)
	 * ret1 previous enable state (%o1)
	 */
	ENTRY(hv_ttrace_enable)
	mov	%o1, %o2
	mov	TTRACE_ENABLE, %o5
	ta	FAST_TRAP
	retl
	stx	%o1, [%o2]
	SET_SIZE(hv_ttrace_enable)

	/*
	 * TTRACE_FREEZE
	 * arg0 enable/ freeze (%o0)
	 * ret0 status (%o0)
	 * ret1 previous freeze state (%o1)
	*/
	ENTRY(hv_ttrace_freeze)
	mov	%o1, %o2
	mov	TTRACE_FREEZE, %o5
	ta	FAST_TRAP
	retl
	stx	%o1, [%o2]
	SET_SIZE(hv_ttrace_freeze)

	/*
	 * MACH_DESC
	 * arg0 buffer real address
	 * arg1 pointer to uint64_t for size of buffer
	 * ret0 status
	 * ret1 return required size of buffer / returned data size
	 */
	ENTRY(hv_mach_desc)
	mov     %o1, %o4                ! save datap
	ldx     [%o1], %o1
	mov     HV_MACH_DESC, %o5
	ta      FAST_TRAP
	retl
	stx   %o1, [%o4]
	SET_SIZE(hv_mach_desc)

	/*
	 * hv_ncs_request(int cmd, uint64_t realaddr, size_t sz)
	 */
	ENTRY(hv_ncs_request)
	mov	HV_NCS_REQUEST, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_ncs_request)

	/*
	 * hv_ra2pa(uint64_t ra)
	 *
	 * MACH_DESC
	 * arg0 Real address to convert
	 * ret0 Returned physical address or -1 on error
	 */
	ENTRY(hv_ra2pa)
	mov	HV_RA2PA, %o5
	ta	FAST_TRAP
	cmp	%o0, 0
	move	%xcc, %o1, %o0
	movne	%xcc, -1, %o0
	retl
	nop
	SET_SIZE(hv_ra2pa)

	/*
	 * hv_hpriv(void *func, uint64_t arg1, uint64_t arg2, uint64_t arg3)
	 *
	 * MACH_DESC
	 * arg0 OS function to call
	 * arg1 First arg to OS function
	 * arg2 Second arg to OS function
	 * arg3 Third arg to OS function
	 * ret0 Returned value from function
	 */
	
	ENTRY(hv_hpriv)
	mov	HV_HPRIV, %o5
	ta	FAST_TRAP
	retl
	nop
	SET_SIZE(hv_hpriv)

#endif	/* lint || __lint */
