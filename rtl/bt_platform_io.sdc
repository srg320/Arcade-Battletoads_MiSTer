# Core-local platform pad contract. This file must follow bt_audio_io.sdc.
# No core clock period or internal core path is relaxed here.
#
# MCP23009 DS20002121C, Table 2-4, Standard mode (100 kHz):
# https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20002121C.pdf
# LOW >=4700 ns, HIGH >=4000 ns, TAA <=3450 ns, data setup >=250 ns,
# data hold >=0 ns, SDA rise <=1000 ns, SDA fall <=300 ns.
# The unmodified sys/i2c.v engine samples 5020 ns after its logical falling
# edge and changes master SDA 80 ns after that edge. See the 500-phase,
# wire-byte, delayed-slave and real-MCP polling proof in tests/verify_bt_platform_io.py.
#
# Supported physical pad envelope, to be checked on the installed board:
# SCL board propagation <=10 ns, fall <=40 ns, rise <=900 ns;
# SDA board propagation <=10 ns each way, rise <=1000 ns, fall <=300 ns.
# Native all-corner report_timing must separately show physical delays <=20 ns
# to IO_SCL, <=50 ns to IO_SDA, <=100 ns from IO_SDA to ACK/rdata.
# Constraints below include clock latency in Quartus 17; they alone cannot
# prove those physical limits. The focused report gate must accompany STA.
# With those limits, worst LOW/HIGH are 4930/4070 ns, master data hold/setup
# are >=10/3860 ns, and worst slave response plus return path is <=4630 ns,
# leaving >=370 ns before the receiver aperture at 5000 ns.

proc bt_platform_fnv {path} {
    set channel [open $path rb]
    fconfigure $channel -translation binary
    set body [string map [list "\r\n" "\n"] [read $channel]]
    close $channel
    set hash 2166136261
    foreach char [split $body {}] {
        scan $char %c value
        set hash [expr {(($hash ^ $value) * 16777619) & 0xffffffff}]
    }
    return [format %08x $hash]
}
set bt_platform_root [file normalize [file join [file dirname [info script]] ..]]
foreach {bt_path bt_hash} {
    sys/i2c.v 0c3635f5
    sys/sys_top.v 5d1a6c2a
    rtl/bt_mcp23009.sv b9396ae6
} {
    if {[bt_platform_fnv [file join $bt_platform_root $bt_path]] ne $bt_hash} {
        error "Platform IO proof source changed: $bt_path; rerun/review the focused proof"
    }
}
set bt_channel [open [file join $bt_platform_root Arcade-Battletoads.sv] r]
set bt_core_source [read $bt_channel]
close $bt_channel
if {![regexp {assign[[:space:]]+USER_OUT[[:space:]]*=[[:space:]]*'1[[:space:]]*;} $bt_core_source] ||
    ![regexp {assign[[:space:]]+\{SD_SCK,[[:space:]]*SD_MOSI,[[:space:]]*SD_CS\}[[:space:]]*=[[:space:]]*'Z[[:space:]]*;} $bt_core_source]} {
    error {Platform IO exceptions require released USER_OUT and inactive core SD SPI outputs}
}

# Quartus may split the same SCLK FF for internal and pad fan-out.
# Source i2c.v, capture edge and physical pad budgets are unchanged. Accept
# only the observed physical SCLK clone; unknown/new aliases require review.
proc bt_platform_validate_scl_names {names} {
    set canonical {}
    foreach name $names {
        set normalized [string map [list "mcp23009:mcp23009|" "mcp23009|" "i2c:i2c|" "i2c|"] $name]
        switch -exact -- $normalized {
            {mcp23009|i2c|I2C_CLOCK} -
            {mcp23009|i2c|SCLK} -
            {mcp23009|i2c|SCLK~DUPLICATE} {lappend canonical $normalized}
            default {error "Unproved MCP23009 SCL register alias: $name"}
        }
    }
    if {[llength $canonical] != [llength [lsort -unique $canonical]]} {
        error {Repeated MCP23009 SCL register aliases}
    }
    foreach mandatory {{mcp23009|i2c|I2C_CLOCK} {mcp23009|i2c|SCLK}} {
        if {[lsearch -exact $canonical $mandatory] < 0} {
            error "Missing mandatory MCP23009 SCL register: $mandatory"
        }
    }
    return [lsort $canonical]
}
set bt_io_scl_regs [get_registers {mcp23009|i2c|I2C_CLOCK mcp23009|i2c|SCLK}]
set bt_io_scl_raw_names {}
foreach_in_collection bt_io_scl_node $bt_io_scl_regs {
    lappend bt_io_scl_raw_names [get_node_info -name $bt_io_scl_node]
}
set bt_io_scl_names [bt_platform_validate_scl_names $bt_io_scl_raw_names]
set bt_io_sda_reg [get_registers {mcp23009|i2c|SDO[3]}]
set bt_io_input_regs [get_registers {mcp23009|i2c|ACK mcp23009|i2c|rdata[*]}]
set bt_io_scl [get_ports IO_SCL]
set bt_io_sda [get_ports IO_SDA]
if {[get_collection_size $bt_io_sda_reg] != 1 ||
    [get_collection_size $bt_io_input_regs] != 6 ||
    [get_collection_size $bt_io_scl] != 1 ||
    [get_collection_size $bt_io_sda] != 1} {
    error {Platform MCP23009 pad endpoints changed; review the phase proof and report gate}
}
# Maximum relationships conservatively include launch/capture clock latency.
# Output minimum is an independently checked clock-edge-to-pad arrival floor;
# the physical proof uses zero as its causal lower bound, not this 1 ns floor.
set_max_delay 20.0 -from $bt_io_scl_regs -to $bt_io_scl
set_min_delay 1.0 -from $bt_io_scl_regs -to $bt_io_scl
set_max_delay 50.0 -from $bt_io_sda_reg -to $bt_io_sda
set_min_delay 1.0 -from $bt_io_sda_reg -to $bt_io_sda
# Input relationship 50/-50 ns requires native capture-clock latency <=50 ns,
# physical input delay <=100 ns. Hold is supplied by the proven bus phase:
# the next slave change is a half-cycle after capture, rather than every CLK.
set_max_delay 50.0 -from $bt_io_sda -to $bt_io_input_regs
set_min_delay -50.0 -from $bt_io_sda -to $bt_io_input_regs

# These pads terminate only inside HPS hard peripherals in the source-bound
# sys_top: HDMI DDC to HPS I2C and HDMI_TX_INT to HPS general-purpose status.
# No FPGA fabric capture or external fabric-launched receiver exists here.
set bt_hps_inputs [get_ports {HDMI_I2C_SDA HDMI_TX_INT}]
set bt_hps_outputs [get_ports {HDMI_I2C_SCL HDMI_I2C_SDA}]
if {[get_collection_size $bt_hps_inputs] != 2 || [get_collection_size $bt_hps_outputs] != 2} {
    error {HPS pad boundary endpoints changed}
}
set_false_path -from $bt_hps_inputs
set_false_path -to $bt_hps_outputs

# Physical status indicators have no synchronous external receiver.
set bt_status_leds [get_ports {LED[0] LED[2] LED[6]}]
# With this core's SD SPI outputs released, sys_top uses these pads only for
# the extra analogue RGB DAC bits and sync-on-green selection. SDCD_SPDIF
# card detect reaches only that analogue mux; its paths end in this collection.
set bt_analogue_sd [get_ports {SDIO_CLK SDIO_CMD SDIO_DAT[*] SD_SPI_CS}]
# SDCD_SPDIF is the self-timed S/PDIF waveform, not synchronous receiver data.
set bt_spdif_pad [get_ports SDCD_SPDIF]
if {[get_collection_size $bt_status_leds] != 3 ||
    [get_collection_size $bt_analogue_sd] != 7 ||
    [get_collection_size $bt_spdif_pad] != 1} {
    error {Asynchronous platform output endpoints changed}
}
set_false_path -to $bt_status_leds
set_false_path -to $bt_analogue_sd
set_false_path -to $bt_spdif_pad

# USER_IO[2/4/5] are optional forwarded I2S, selected by SW[1]. USER_OUT='1
# guarantees their other selection is released. Support the same 2 ns
# setup/hold plus 0.25 ns skew envelope qualified at the HDMI I2S outputs.
# Connector pull-ups and receiver loading must meet that envelope physically.
if {![info exists bt_i2s_q] || ![info exists bt_audio_registers] ||
    [get_collection_size [get_clocks bt_audio_sclk_internal]] != 1} {
    error {bt_platform_io.sdc must follow the qualified bt_audio_io.sdc}
}
set bt_user_sclk [get_ports {USER_IO[4]}]
set bt_user_i2s_data [get_ports {USER_IO[2] USER_IO[5]}]
if {[get_collection_size $bt_user_sclk] != 1 || [get_collection_size $bt_user_i2s_data] != 2} {
    error {Forwarded USER I2S pad endpoints changed}
}
create_generated_clock -name bt_user_i2s -source $bt_i2s_q \
    -master_clock bt_audio_sclk_internal -divide_by 1 $bt_user_sclk
set_output_delay -clock bt_user_i2s -max 2.25 $bt_user_i2s_data
set_output_delay -clock bt_user_i2s -min -2.25 $bt_user_i2s_data
set_multicycle_path -setup -start 5 -from $bt_audio_registers -to $bt_user_i2s_data
set_multicycle_path -hold -start 7 -from $bt_audio_registers -to $bt_user_i2s_data
derive_clock_uncertainty
