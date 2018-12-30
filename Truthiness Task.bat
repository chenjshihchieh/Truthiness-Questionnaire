cd "%~dp0\Truthiness_Task"
call RunR.bat
set /p Location=<location.txt
%Location% CMD BATCH --no-save run.R