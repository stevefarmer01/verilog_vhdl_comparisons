#Example Design Directory Tree in Non-Project Mode...
#
#|-- vivado_reports
#|   `-- reports/dcp's from FPGA building process
#|-- simulation_source
#|   `-- blahblahblah_tb.v
#|-- waveform
#|  `-- blahblahblah.wcfg
#`-- sources
#|   |-- constraint
#|   |  |-- blahblahblah_top_physical.xdc
#|   |  `-- blahblahblah_top_timing.xdc
#|   |-- verilog
#|   |  |-- blahblahblah.v
#|   |  `-- blahblahblah_top.v
#|   `-- vhdl
#|       `-- blahblahblah.vhd
#|--implementation_example
#   |-- common_ip testbench/implmentation stuff
#
#
# create_bft_batch.tcl
# bft sample design
# A Vivado script that demonstrates a very simple RTL-to-bitstream batch flow
#
# NOTE: typical usage would be "vivado -mode tcl -source create_bft_batch.tcl"
#
# STEP#0: define output directory area.
#
set outputDir ./vivado_reports
file delete -force $outputDir
file mkdir $outputDir
##
## STEP#1: setup design sources and constraints
##
#read_vhdl -library work [ glob ../sources/hdl/vhdl/*.vhd ]
read_vhdl -library work ../sources/hdl/vhdl/synth_sim_constant_pkg.vhd
read_vhdl -library work ../sources/hdl/vhdl/test_pattern_gen_ccd_bfm.vhd
read_xdc ../sources/constraint/test_pattern_gen_ccd.xdc

## - EXAMPLE - 
#read_vhdl -library bftLib [ glob ./Sources/hdl/bftLib/*.vhdl ]
#read_vhdl ./Sources/hdl/bft.vhdl
#read_verilog [ glob ./Sources/hdl/*.v ]
#read_xdc ./Sources/bft_full.xdc

#read_edif *.edif
#read_ip *.xco *.xci

##
## STEP#2: run synthesis, report utilization and timing estimates, write checkpoint
#design
##
synth_design -top test_pattern_gen_ccd_bfm -part xc7a35tcsg325-1 -flatten rebuilt
# write_checkpoint -force $outputDir/post_synth
# #report_timing -file $outputDir/post_synth_timing.rpt
# report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
# report_power -file $outputDir/post_synth_power.rpt
##
## STEP#3: run placement and logic optimization, report utilization and timing
#estimates, write checkpoint design
##
opt_design
# power_opt_design
place_design
phys_opt_design
# write_checkpoint -force $outputDir/post_place
# report_timing_summary -file $outputDir/post_place_timing_summary.rpt
##
## STEP#4: run router, report actual utilization and timing, write checkpoint design,
#run drc, write verilog and xdc out
##
route_design
place_design -post_place_opt
phys_opt_design
route_design
# Generate reports and design checkpoint
write_checkpoint -force $outputDir/post_route
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 5 -path_type summary -file $outputDir/post_route_timing.rpt
# report_clock_utilization -file $outputDir/clock_util.rpt
report_utilization -file $outputDir/post_route_util.rpt
# report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
# write_verilog -force $outputDir/artix_headboard_impl_netlist.v
# write_xdc -no_fixed_only -force $outputDir/artix_headboard_impl.xdc
##
## STEP#5: generate a bitstream
##
# Reduce these failures down to warnings to allow bit file to be generated without LOC constaints being applied to pins
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

write_bitstream -force -bin_file $outputDir/test_pattern_gen_ccd_bfm.bit
#write_bitstream $outputDir/bft.bit