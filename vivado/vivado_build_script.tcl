#Example Design Directory Tree in Non-Project Mode...
#
#|-- vivado_reports
#|   `-- stuff for building FPGA
#|-- vivado_temp_files
#|   `-- stuff for building FPGA
#|-- simulation_source
#|   `-- spectrum_top_tb.v
#|-- waveform
#|  `-- hw_ila_data_1.wcfg
#`-- sources
#    |-- constraint
#    |  |-- spectrum_top_physical.xdc
#    |  `-- spectrum_top_timing.xdc
#    |-- verilog
#    |  |-- cplx_mult.v
#    |  `-- spectrum_top.v
#    `-- vhdl
#        `-- heartbeat_gen.vhd
#
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

#Part number is set in 'artix_headboard_eval_ip_build_script' so that both modelsim and vivado build/simulate with the same part number
#set part_number xc7a35tcsg325-1

#Create local area to regenerate IP because problems can be cause when pulling repositories with changed IP changing .xci files after reading existing generated files
#Use separate script for IP generation because modelsim needs to regenerate IP too as it contains files required for simulation 

#This line does not stop webtalk being sent to Xilinx because we are using a WEBPack license. However, it does stop lots of annoying 
#config_webtalk -install off

source vivado_ip_build_script.tcl

set outputDir ./vivado_reports
set outputDir_prev_run ./vivado_reports_previous_run
file delete -force $outputDir_prev_run
#If this first run then directory "./vivado_reports" will not exist
set dir_exists [file isdirectory $outputDir]
if {$dir_exists == 1} {file copy -force $outputDir $outputDir_prev_run}

file delete -force $outputDir
file mkdir $outputDir

###
### STEP#1: setup design sources and constraints
###
##HDL source
##common_ip cource code
#read_vhdl -library work [ glob ../common_ip/test_pattern_gen_ccd/local_common_ip/domain_cross/source/*.vhd ]
#read_vhdl -library work [ glob ../common_ip/test_pattern_gen_ccd/local_common_ip/multi_dimensional_arrays/sources/hdl/vhdl/*.vhd ]
#read_vhdl -library work [ glob ../common_ip/test_pattern_gen_ccd/sources/hdl/vhdl/*.vhd ]
#read_vhdl -library work [ glob ../common_ip/fpga_reset/source/*.vhd ]
##main project source code
#read_vhdl -library work [ glob ../sources/hdl/vhdl/*.vhd ]
##XDC constraints
#read_xdc ../sources/constraint/artix_headboard_eval.xdc
#
#report_compile_order -constraints
#
#
#
#
###
### STEP#2: run synthesis, report utilization and timing estimates, write checkpoint
##design
###
#synth_design -top artix_headboard_eval_top -part $part_number -flatten rebuilt
## write_checkpoint -force $outputDir/post_synth
## #report_timing -file $outputDir/post_synth_timing.rpt
## report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
## report_power -file $outputDir/post_synth_power.rpt
###
### STEP#3: run placement and logic optimization, report utilization and timing
##estimates, write checkpoint design
###
#opt_design
## power_opt_design
#place_design
#phys_opt_design
## write_checkpoint -force $outputDir/post_place
## report_timing_summary -file $outputDir/post_place_timing_summary.rpt
###
### STEP#4: run router, report actual utilization and timing, write checkpoint design,
##run drc, write verilog and xdc out
###
#route_design
#place_design -post_place_opt
#phys_opt_design
#route_design
## Generate reports and design checkpoint
#write_checkpoint -force $outputDir/post_route
#report_timing_summary -file $outputDir/post_route_timing_summary.rpt -report_unconstrained
#report_timing -sort_by group -max_paths 5 -path_type summary -file $outputDir/post_route_timing.rpt
## report_clock_utilization -file $outputDir/clock_util.rpt
#report_utilization -file $outputDir/post_route_util.rpt
## report_power -file $outputDir/post_route_power.rpt
#report_drc -file $outputDir/post_imp_drc.rpt
## write_verilog -force $outputDir/artix_headboard_impl_netlist.v
## write_xdc -no_fixed_only -force $outputDir/artix_headboard_impl.xdc
##If below fails ensure that 'UltraFast Design Methodology' is installed via the Vivado TCL store this is as per https://forums.xilinx.com/t5/Welcome-Join/checking-if-registers-are-in-IOB/td-p/707421
#xilinx::ultrafast::report_io_reg -verbose -file $outputDir/post_route_iob.rpt
#
###
### STEP#5: generate a bitstream
###
## Reduce these failures down to warnings to allow bit file to be generated without LOC constaints being applied to pins
#set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
#set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
#
#write_bitstream -force -bin_file $outputDir/test_pattern_gen_ccd_bfm.bit
##write_bitstream $outputDir/bft.bit