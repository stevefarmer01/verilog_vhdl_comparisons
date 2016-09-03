rem runs viado simulation batch files with GUI if batch is called with the word "gui" following it and displays resulting waveform in GUI
rmdir /s /q simulate
mkdir simulate
call xelab_batch.bat
cd ..
if "%1" == "gui" (
	call simulate_xsim_gui.bat
) ELSE (
	call simulate_xsim_no_gui.bat
)
cd ..
