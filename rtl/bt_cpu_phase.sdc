# Qualified CE_R -> CE_R paths only. bt_clock_enables produces R at slots
# 2 and 4 of each five-system-clock group: minimum separation is two cycles.
# The explicit source/target list is the CE_R-only state in TMS34020.sv.
# RF write ports commit only under CE_R (REG_WE & EN & CE). Opposite-phase
# memory, cache, bus and video-counter registers are absent from this list.
# The selected CPU-writable IO parameters below have a CE_R-only owner.
# Native runs with MISTER_CPU_PHASE_CHECK assert source-register stability.
# OPSEL_ALU_FSI_OH follows OPSEL on the same EN && CE_R instruction/state
# update edges; its identity and R-phase stability are asserted in the CPU.
set bt_cpu_r_registers [get_registers {
    *|CPU|IC[*]* *|CPU|IC_MATCHES[*]* *|CPU|IC_RS_STATIC[*]* *|CPU|IC_RF_ADDR[*]* *|CPU|IC_RF_ADDR_POS[*]* *|CPU|OPSEL[*]* *|CPU|OPSEL.* *|CPU|IW[*]* *|CPU|PC[*]*
    *|CPU|OPSEL_ALU_FSI_OH[*]*
    *|CPU|STATE[*]* *|CPU|STATE_OH[*]* *|CPU|MD_ACC[*]*
    *|CPU|RST_EXEC *|CPU|WORD_MASK[*]* *|CPU|LIST[*]* *|CPU|MM_RN[*]*
    *|CPU|MD_SHIFT[*]* *|CPU|MD_Q[*]* *|CPU|MD_STEP[*]*
    *|CPU|MD_COND *|CPU|MD_NEG *|CPU|DIV_V *|CPU|DS_Z *|CPU|ST.*
    *|CPU|WSTART[*]* *|CPU|WEND[*]* *|CPU|COLOR0[*]*
    *|CPU|COLOR1[*]* *|CPU|PATTERN[*]* *|CPU|RP_COND
    *|CPU|PIX_XEND *|CPU|PIX_YEND *|CPU|PIX_BL
    *|CPU|PIXBLT_PPW[*]* *|CPU|PIXBLT_X[*]* *|CPU|PIX_POS.*
    *|CPU|PIX_BIT[*]* *|CPU|PIX_BITV[*]* *|CPU|PIX_NE[*]* *|CPU|LINE_GZ *|CPU|LINE_COND
    *|CPU|PIX_DOFFS[*]* *|CPU|PIX_SOFFS[*]* *|CPU|PIX_MOFFS[*]*
    *|CPU|PIX_DYDX.* *|CPU|PIX_WINCC[*]*
    *|CPU|CACHE|SSA[*]* *|CPU|MC|DBUS_BE[*]* *|CPU|MC|MC_WMASK_EXT[*]*
    *|CPU|MC|READ_WORD_E[*]* *|CPU|MC|READ_PREVIOUS_E[*]* *|CPU|MC|READ_ALIGN_E[*]* *|CPU|MC|READ_SIZE_E[*]* *|CPU|MC|READ_OLD_SIZE_E[*]* *|CPU|MC|READ_EXTENDED_E
}]
# MC READ_*_E (the early read-capture group) load in the clocks between a
# READ_LATCH-setting CE_F and the next CE_F; the CPU consumes them at the CE_R
# after that CE_F, always >= 2 clocks after their last load (TMS34020_MC.sv
# asserts this in simulation). They are sources here, never targets of R logic.
# The cache segment start addresses commit only under EN && CE_R (CACHE_WR),
# TMS34020_CACHE.sv. DBUS_BE loads only in the CE_R after a launch
# (TMS34020_MC.sv BE_PEND). Both are part of the native R-phase stability view.
if {[get_collection_size [get_registers {*|CPU|CACHE|SSA[*]*}]] == 0} {
    error {Instruction cache segment start registers did not resolve}
}
set bt_cpu_rf_r_targets [get_registers {
    *|CPU|RF|regram*|*OBSERVABLEPORTADATAINREGOUT*
}]
set bt_cpu_rf_r_memory [get_registers {
    *|CPU|RF|regram*|*MEMORYREGOUT*
}]
set bt_cpu_io_r_parameters [get_registers {
    *|CPU|IO|IO_REGS.PSIZE* *|CPU|IO|IO_REGS.CONTROL.*
    *|CPU|IO|IO_REGS.CONVSP* *|CPU|IO|IO_REGS.CONVDP* *|CPU|IO|IO_REGS.CONVMP*
}]
# The RF's MLAB read address and output are unregistered. Its data input
# commits only under REG_WE & EN & CE_R. TimeQuest represents the stored
# MLAB data separately as MEMORYREGOUT; both the write input and stored data
# are R sources. Read addresses derive from the R-only instruction/state.
set bt_cpu_r_sources [add_to_collection $bt_cpu_r_registers $bt_cpu_rf_r_targets]
set bt_cpu_r_sources [add_to_collection $bt_cpu_r_sources $bt_cpu_rf_r_memory]
set bt_cpu_r_sources [add_to_collection $bt_cpu_r_sources $bt_cpu_io_r_parameters]
set bt_cpu_r_targets [add_to_collection $bt_cpu_r_registers $bt_cpu_rf_r_targets]
set bt_cpu_r_targets [add_to_collection $bt_cpu_r_targets $bt_cpu_io_r_parameters]
if {[get_collection_size $bt_cpu_r_sources] == 0 ||
    [get_collection_size $bt_cpu_r_targets] == 0} {
    error {Battletoads CPU phase endpoints did not resolve}
}
set_multicycle_path -setup -end 2 -from $bt_cpu_r_sources -to $bt_cpu_r_targets
set_multicycle_path -hold -end 1 -from $bt_cpu_r_sources -to $bt_cpu_r_targets
puts "BT_CPU_PHASE sources=[get_collection_size $bt_cpu_r_sources] targets=[get_collection_size $bt_cpu_r_targets] rf_write_targets=[get_collection_size $bt_cpu_rf_r_targets] rf_stored_data=[get_collection_size $bt_cpu_rf_r_memory] io_parameters=[get_collection_size $bt_cpu_io_r_parameters] minimum_system_cycles=2"
# MEMORYREGOUT exists in the fitted timing netlist. The fitter's early netlist
# can omit those physical node names; the final audit requires them to resolve.
