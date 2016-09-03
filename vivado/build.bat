call C:\Xilinx\Vivado\2016.2\settings64.bat
rem vivado -mode batch -source vivado_build.tcl -nolog -nojournal
rem Put annoying but useful viiado .log and .jou files into sub-directory 'vivado_logs' and direct vivado to put htem in this location
mkdir vivado_logs
vivado -mode batch -source vivado_build_script.tcl -log vivado_logs\vivado.log -journal vivado_logs\vivado.jou