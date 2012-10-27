@echo off


:LOOP1
echo delaying 60secs
 PING 1.1.1.1 -n 1 -w 60000 >NUL
tools\disablealttab.bat
GOTO LOOP1