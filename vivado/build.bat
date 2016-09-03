call C:\Xilinx\Vivado\set_xilinx_vivado_2014_1.bat
rem vivado -mode batch -source test_pattern_gen_ccd.tcl -nolog -nojournal
mkdir vivado_logs
vivado -mode batch -source test_pattern_gen_ccd.tcl -log vivado_logs\vivado.log -journal vivado_logs\vivado.jou