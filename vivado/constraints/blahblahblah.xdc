create_clock -period 10.000 -name SystemClk [get_ports SystemClk]
set_input_delay -clock [get_clocks SystemClk] -max -add_delay 6.000 [get_ports signal_in_bit]
set_input_delay -clock [get_clocks SystemClk] -min -add_delay 2.000 [get_ports signal_in_bit]
set_output_delay -clock [get_clocks SystemClk] -max -add_delay 3.000 [get_ports signal_out_bit]
set_output_delay -clock [get_clocks SystemClk] -min -add_delay -1.000 [get_ports signal_out_bit]

set_property IOB TRUE [all_inputs] 
set_property IOB TRUE [all_outputs]

