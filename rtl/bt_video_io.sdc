# ADV7513 Rev. B, AC specifications: video setup 1.8 ns, hold 1.3 ns.
# https://www.analog.com/media/en/technical-documentation/data-sheets/adv7513.pdf
# Add a 0.25 ns design budget for relative board clock/data skew.
# The DDIO clock pin is inverted; data launches on hdmi_tx_clk's rising edge.
set bt_hdmi_source [get_pins -compatibility_mode {hdmi_clk_sw|outclk}]
if {[get_collection_size $bt_hdmi_source] != 1} {
    error {Battletoads HDMI timing: the clock mux output must resolve exactly once}
}
set bt_hdmi_masters 0
foreach_in_collection bt_clock [get_clocks *] {
    set bt_clock_name [get_clock_info -name $bt_clock]
    set bt_external_name {}
    if {[string first {emu|pll|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} $bt_clock_name] == 0} {
        set bt_external_name bt_hdmi_native
    } elseif {[string first {pll_hdmi|pll_hdmi_inst|} $bt_clock_name] == 0 &&
              [string first {.output_counter|divclk} $bt_clock_name] >= 0} {
        set bt_external_name bt_hdmi_scaled
    }
    if {$bt_external_name ne {}} {
        create_generated_clock -name $bt_external_name -source $bt_hdmi_source \
            -master_clock $bt_clock_name -divide_by 1 -invert -add [get_ports HDMI_TX_CLK]
        set_output_delay -clock $bt_external_name -max 2.05 -add_delay \
            [get_ports {HDMI_TX_D[*] HDMI_TX_DE HDMI_TX_HS HDMI_TX_VS}]
        set_output_delay -clock $bt_external_name -min -1.55 -add_delay \
            [get_ports {HDMI_TX_D[*] HDMI_TX_DE HDMI_TX_HS HDMI_TX_VS}]
        incr bt_hdmi_masters
    }
}
if {$bt_hdmi_masters != 2} {
    error {Battletoads HDMI timing: native and scaled master clocks must both exist}
}
# Extend the existing mutually exclusive native/scaler groups to their pins.
set_clock_groups -exclusive \
    -group [get_clocks {*|pll|pll_inst|altera_pll_i|*[*].*|divclk bt_hdmi_native}] \
    -group [get_clocks {pll_hdmi|pll_hdmi_inst|altera_pll_i|*[0].*|divclk bt_hdmi_scaled}]
derive_clock_uncertainty
