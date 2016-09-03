call C:\Xilinx\Vivado\set_xilinx_vivado_2014_1.bat
cd simulate
xelab -generic_top "no_text_vector_input_file_g=TRUE" --debug typical --snapshot tb_multi_dimensional_array --prj ..\simulate_xsim.prj tb_multi_dimensional_array