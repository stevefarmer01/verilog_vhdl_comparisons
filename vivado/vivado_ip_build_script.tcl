#Create local area to regenerate IP because problems can be cause when pulling repositories with changed IP changing .xci files after reading existing generated files
#This is as per UG939

set part_number xc7a35tcsg325-1

#set ip_generation_directory ./vivado_ip_regeneration
#file delete -force $ip_generation_directory
#file mkdir $ip_generation_directory
#
#set clk_wiz_0_directory ${ip_generation_directory}/clk_wiz_0
#set clk_wiz_1_directory ${ip_generation_directory}/clk_wiz_1
#set camera_tap_input_fifo_directory ${ip_generation_directory}/camera_tap_input_fifo
##Make regeneration directories
#file mkdir $clk_wiz_0_directory
#file mkdir $clk_wiz_1_directory
#file mkdir $camera_tap_input_fifo_directory
#
#set ip_source_directory ../sources/ip/vivado_ip
##Copy IP .xci files from sources to local build regeneration directory
#file copy -force ${ip_source_directory}/clk_wiz_0/clk_wiz_0.xci $clk_wiz_0_directory
#file copy -force ${ip_source_directory}/clk_wiz_1/clk_wiz_1.xci $clk_wiz_1_directory
#file copy -force ${ip_source_directory}/camera_tap_input_fifo/camera_tap_input_fifo.xci $camera_tap_input_fifo_directory
#
#
###
### STEP#0: regenerate IP from .xci files - this must be done within a project for IP
###
##vivado IP - recreate IP inside of in memory project - for OOC re-generate IP using ./vivado_ip/managed_ip_project/managed_ip_project.xpr and comment out all lines below except read_ip
#create_project -in memory -part  $part_number
#set_property target_language VHDL [current_project]
#
##Main clock MMCM
#read_ip ${clk_wiz_0_directory}/clk_wiz_0.xci
##From UG939 - Lab 5 - Now when synthesis is done of the top level the RTL output products will be used and a DCP will not be expected...
#set_property generate_synth_checkpoint true [get_files clk_wiz_0.xci]
#generate_target all [get_ips clk_wiz_0] -force
##set clk_wiz_0_xdc [get_files -of_objects [get_files clk_wiz_0.xci] -filter {FILE_TYPE == XDC}]
##set_property is_enabled false [get_files $clk_wiz_0_xdc]
#export_ip_user_files -of_objects [get_files ${clk_wiz_0_directory}/clk_wiz_0.xci] -no_script -force -quiet
#create_ip_run [get_files -of_objects [get_fileset sources_1] ${clk_wiz_0_directory}/clk_wiz_0.xci]
#synth_ip [get_ips clk_wiz_0]
#export_simulation -of_objects [get_files ${clk_wiz_0_directory}/clk_wiz_0.xci] -directory ${ip_generation_directory}/ip_user_files/sim_scripts -ip_user_files_dir ${ip_generation_directory}/ip_user_files -ipstatic_source_dir ${ip_generation_directory}/ip_user_files/ipstatic -force -quiet
#
#
##Camera clock MMCM
#read_ip ${clk_wiz_1_directory}/clk_wiz_1.xci
##From UG939 - Lab 5 - Now when synthesis is done of the top level the RTL output products will be used and a DCP...
#set_property generate_synth_checkpoint true [get_files clk_wiz_1.xci]
#generate_target all [get_ips clk_wiz_1] -force
##set clk_wiz_0_xdc [get_files -of_objects [get_files clk_wiz_0.xci] -filter {FILE_TYPE == XDC}]
##set_property is_enabled false [get_files $clk_wiz_0_xdc]
#export_ip_user_files -of_objects [get_files ${clk_wiz_1_directory}/clk_wiz_1.xci] -no_script -force -quiet
#create_ip_run [get_files -of_objects [get_fileset sources_1] ${clk_wiz_1_directory}/clk_wiz_1.xci]
#synth_ip [get_ips clk_wiz_1]
#export_simulation -of_objects [get_files ${clk_wiz_1_directory}/clk_wiz_1.xci] -directory ${ip_generation_directory}/ip_user_files/sim_scripts -ip_user_files_dir ${ip_generation_directory}/ip_user_files -ipstatic_source_dir ${ip_generation_directory}/ip_user_files/ipstatic -force -quiet
#
##Domain Crossing FIFO IP
#read_ip ${camera_tap_input_fifo_directory}/camera_tap_input_fifo.xci
##From UG939 - Lab 5 - Now when synthesis is done of the top level the RTL output products will be used and a DCP...
#set_property generate_synth_checkpoint true [get_files camera_tap_input_fifo.xci]
#generate_target all [get_ips camera_tap_input_fifo] -force
##Lines below commented out because it is a good idea to use ip's xdc's for checking top level clock constraints exist and for ignoring domain crossing asyn paths
##set camera_tap_input_fifo_xdc [get_files -of_objects [get_files camera_tap_input_fifo.xci] -filter {FILE_TYPE == XDC}]
##set_property is_enabled false [get_files $camera_tap_input_fifo_xdc]
#export_ip_user_files -of_objects [get_files ${camera_tap_input_fifo_directory}/camera_tap_input_fifo.xci] -no_script -force -quiet
#create_ip_run [get_files -of_objects [get_fileset sources_1] ${camera_tap_input_fifo_directory}/camera_tap_input_fifo.xci]
#synth_ip [get_ips camera_tap_input_fifo]
#export_simulation -of_objects [get_files ${camera_tap_input_fifo_directory}/camera_tap_input_fifo.xci] -directory ${ip_generation_directory}/ip_user_files/sim_scripts -ip_user_files_dir ${ip_generation_directory}/ip_user_files -ipstatic_source_dir ${ip_generation_directory}/ip_user_files/ipstatic -force -quiet
#
#####Do not close project because it causes slighly concerning warning - * Current project part 'xc7k70tfbg676-1' and the part 'xc7a35tcsg325-1' used to customize the IP 'camera_tap_input_fifo' do not match.
###Close IP regeneration project
##close_project
#
#
############################################################################################################################################################
### - EXAMPLE - 
##read_vhdl -library bftLib [ glob ./Sources/hdl/bftLib/*.vhdl ]
##read_vhdl ./Sources/hdl/bft.vhdl
##read_verilog [ glob ./Sources/hdl/*.v ]
##read_xdc ./Sources/bft_full.xdc
#
##read_edif *.edif
##read_ip *.xco *.xci
#
##create_project -in_memory -part xc7vx415tffg1158-2
##read_ip ./local_pcs_pma/local_pcs_pma.xci
##set_property target_language VHDL [current_project]
##generate_target all [get_files ./local_pcs_pma/local_pcs_pma.xci]
#
##create_project -in_memory -part xc7a35tcsg325-1
##
##file mkdir ./vivado_ip/fifo_generator_0/fifo_generator_0.xci
##file copy -force ./sources/vivado_ip/fifo_generator_0/fifo_generator_0.xci ./vivado_ip/fifo_generator_0/fifo_generator_0.xci
##
##
##read_ip ./sources/vivado_ip/fifo_generator_0/fifo_generator_0.xci
##
##set_property generate_synth_checkpoint false [get_files fifo_generator_0.xci]
##
##generate_target all [get_ips fifo_generator_0]
#
#
##read_ip ./sources/vivado_ip/camera_tap_input_fifo/camera_tap_input_fifo.xci
###generate_target all [get_ips camera_tap_input_fifo]
##
###set_property is_locked false [get_files ./sources/vivado_ip/camera_tap_input_fifo/camera_tap_input_fifo.xci]
##generate_target synthesis [get_files ./sources/vivado_ip/camera_tap_input_fifo/camera_tap_input_fifo.xci]

