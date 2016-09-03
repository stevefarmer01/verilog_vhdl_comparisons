rem remove project's modelsim compilation libraries directory
@RD /S /Q "test_pattern_gen_ccd_bfm"

rem Used to find modelsim pre-compiled vivado libraries - migth be an idea to put thi line in the root directory so that vivado and modelsim scripts can use it
set VIVADO_VERSION=vivado_2014_1

vlib test_pattern_gen_ccd_bfm
vmap work test_pattern_gen_ccd_bfm

rem packages
vcom -93 ../sources/hdl/vhdl/synth_sim_constant_pkg.vhd

rem top level of DUT's
vcom -93 ../sources/hdl/vhdl/test_pattern_gen_ccd_bfm.vhd

rem rem top level testbench instantiating 'gdrb_ctrl.vhd' and 'gdrb_dpmux.vhd' as DUT's
rem vcom -93 source/gdrb_testbench.vhd

rem Call modelsim gui mode if batch name followed by string "gui" otherwise run modelsim in batch mode and exit when finished
rem Add commands to prevent Modelsim issuing maths warnings at time 0

SET do_string_gui="radix -hexadecimal; do wave.do; log -r *; set StdArithNoWarnings 1; set NumericStdNoWarnings 1; run 0 ns; set StdArithNoWarnings 0; set NumericStdNoWarnings 0; run -all; wave zoom full;"
SET do_string_no_gui="radix -hexadecimal; do wave.do; log -r *; set StdArithNoWarnings 1; set NumericStdNoWarnings 1; run 0 ns; set StdArithNoWarnings 0; set NumericStdNoWarnings 0; run -all;"
SET exit_string=" exit;"

if "%1" == "gui" (
	SET BATCH_MODE=""
	SET "do_string=%do_string_gui%"
) ELSE (
	SET BATCH_MODE="-c" 
	SET do_string="%do_string_no_gui:"=%%exit_string:"=%"
)
rem	vsim -gtestbench_mode_g=FALSE  %BATCH_MODE% -wlf test_pattern_gen_ccd_bfm.wlf -novopt -t ps -do %do_string% test_pattern_gen_ccd_bfm
	vsim  %BATCH_MODE% -wlf test_pattern_gen_ccd_bfm.wlf -novopt -t ps -do %do_string% test_pattern_gen_ccd_bfm -wlfslim 10240
