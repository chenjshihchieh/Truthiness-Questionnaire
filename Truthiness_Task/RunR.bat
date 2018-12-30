FOR /F "usebackq delims=" %%G IN (`where /R "C:\Program Files" /F R.exe`) DO ECHO %%G > location.txt
