onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 74 -max 1024.0 -radix unsigned /test_pattern_gen_ccd_bfm/camera_data_out
add wave -noupdate /test_pattern_gen_ccd_bfm/camera_data_out
add wave -noupdate /test_pattern_gen_ccd_bfm/clk_out
add wave -noupdate /test_pattern_gen_ccd_bfm/clk_s
add wave -noupdate /test_pattern_gen_ccd_bfm/line_length_count_s
add wave -noupdate /test_pattern_gen_ccd_bfm/clk_stop_s
add wave -noupdate -divider FSM
add wave -noupdate /test_pattern_gen_ccd_bfm/test_pattern_fsm_proc/test_pattern_state_v
add wave -noupdate /test_pattern_gen_ccd_bfm/test_pattern_fsm_proc/active_pixel_v
add wave -noupdate /test_pattern_gen_ccd_bfm/test_pattern_fsm_proc/line_length_count_v
add wave -noupdate /test_pattern_gen_ccd_bfm/test_pattern_fsm_proc/line_gap_count_v
add wave -noupdate /test_pattern_gen_ccd_bfm/test_pattern_fsm_proc/line_count_v
add wave -noupdate /test_pattern_gen_ccd_bfm/test_pattern_fsm_proc/frame_gap_count_v
add wave -noupdate /test_pattern_gen_ccd_bfm/test_pattern_fsm_proc/number_of_frames_count_v
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25934659 ps} 0}
configure wave -namecolwidth 313
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {5569343 ps} {59330657 ps}
