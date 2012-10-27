@echo off
echo killing disablealttab.exe then starting it!
TASKKILL /F /IM disablealttab.exe
start  tools/disablealttab.exe