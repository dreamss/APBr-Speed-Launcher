@echo off
IF NOT EXIST "settings.ini" GOTO NOINI
for /f "tokens=1,2 delims==" %%a in (settings.ini) do ( 
set %%a=%%b
) 




set PATCHFOLDER=patches\
set LOGFOLDER=log\

ECHO KILLING VIVOX!
TASKKILL /F /IM VivoxVoiceService.exe
IF EXIST "C:\Users\dreamss"  set APBPATH=d:\games\apb
IF NOT EXIST "%APBPATH%\Binaries\Apb.exe" GOTO NOAPBDIR
IF EXIST "C:\Users\dreamss" GOTO DREAMSSAREA

IF "X%DELETEINTROMOVIES%"=="X1" GOTO RENTRASH
goto PATCHCONFIGS
GOTO EXIT

:DREAMSSAREA
echo Setting up dreamss custom settings..
set MAKEREADONLY=0
set COPYCONFIGFILES=1
set DISABLEALTTAB=1
set SETAFFINITY=1
set AFFINITYBIT=55
set DELAYWAITTIMER=40000
set APBPATH=d:\games\apb
set CHANGEAPBVOLUME=1
set APBVOLUMELEVEL=0.2
set PATCHCONFIGFILES=1
GOTO RENTRASH
 
:DISABLEALTTAB
IF "X%CHANGEAPBVOLUME%"=="X1" echo Already waited %DELAYWAITTIMER%ms, Just gonna disable the alttab!
IF NOT "X%CHANGEAPBVOLUME%"=="X1" echo Waiting %DELAYWAITTIMER%ms then disabling the alttab!
IF NOT "X%CHANGEAPBVOLUME%"=="X1" PING 1.1.1.1 -n 1 -w %DELAYWAITTIMER% >NUL
 tools\disablealttab.bat
GOTO EXIT

:RENTRASH
 

goto PATCHCONFIGS

:NOAPBDIR
echo ERROR!
echo "%APBPATH%\Binaries\Apb.exe" not found! 
echo Please edit APBPATH. THANKYOU!
echo.
pause
GOTO EXIT

:CHANGEVOLUME
echo Waiting %DELAYWAITTIMER%ms then going to change the volume.
PING 1.1.1.1 -n 1 -w %DELAYWAITTIMER% >NUL
for /f "TOKENS=1" %%c in ('wmic PROCESS where "Name='apb.exe'" get ProcessID ^| findstr [0-9]') do (
echo Found APB pid: %%c, setting volume to %APBVOLUMELEVEL%
tools\nircmd.exe setappvolume /%%c %APBVOLUMELEVEL%
)
IF "X%DISABLEALTTAB%"=="X1" GOTO DISABLEALTTAB
GOTO EXIT


:RUNAPB
IF "X%SETAFFINITY%"=="X1" GOTO RUNAPBAFFINITY
echo Starting APBr!
start /d  "%APBPATH%\Binaries\" Apb.exe -nomoviestartup
IF "X%CHANGEAPBVOLUME%"=="X1" GOTO CHANGEVOLUME
IF "X%DISABLEALTTAB%"=="X1" GOTO DISABLEALTTAB
GOTO EXIT

:RUNAPBAFFINITY
echo Starting APBr and settin affinty to %AFFINITYBIT%!
start /affinity %AFFINITYBIT% /d   "%APBPATH%\Binaries\" Apb.exe  -nomoviestartup
IF "X%CHANGEAPBVOLUME%"=="X1" GOTO CHANGEVOLUME
IF "X%DISABLEALTTAB%"=="X1" GOTO DISABLEALTTAB
GOTO EXIT

:PATCHCONFIGS
IF NOT "X%PATCHCONFIGFILES%"=="X1" goto RUNAPB
echo Patching Config files...
attrib  -r "%APBPATH%\Engine\Config\BaseEngine.ini" 
attrib  -r "%APBPATH%\APBGame\Config\APBEngine.ini"
attrib  -r "%APBPATH%\APBGame\Config\APBCompat.ini"
attrib  -r "%APBPATH%\APBGame\Config\APBCompat_Dev.ini"
attrib  -r "%APBPATH%\Engine\Config\BaseInput.ini"
attrib  -r "%APBPATH%\APBGame\Config\APBInput.ini"
attrib  -r "%APBPATH%\APBGame\Config\DefaultInput.ini"

patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseEngine.ini" %PATCHFOLDER%%PATCHFILE1%  >%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBEngine.ini" %PATCHFOLDER%%PATCHFILE1%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseEngine.ini" %PATCHFOLDER%%PATCHFILE2%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBEngine.ini" %PATCHFOLDER%%PATCHFILE2%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseEngine.ini" %PATCHFOLDER%%PATCHFILE3%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBEngine.ini" %PATCHFOLDER%%PATCHFILE3%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseEngine.ini" %PATCHFOLDER%%PATCHFILE4%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBEngine.ini" %PATCHFOLDER%%PATCHFILE4%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseEngine.ini" %PATCHFOLDER%%PATCHFILE5%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBEngine.ini" %PATCHFOLDER%%PATCHFILE5%  >>%LOGFOLDER%/patch.log

patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBCompat.ini" %PATCHFOLDER%%PATCHFILE6%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBCompat_Dev.ini" %PATCHFOLDER%%PATCHFILE6%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBEngine.ini" %PATCHFOLDER%%PATCHFILE7%  >>%LOGFOLDER%/patch.log

patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseInput.ini" %PATCHFOLDER%%PATCHFILE8%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseInput.ini" %PATCHFOLDER%%PATCHFILE9%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseInput.ini" %PATCHFOLDER%%PATCHFILE10%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseInput.ini" %PATCHFOLDER%%PATCHFILE11%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\Engine\Config\BaseInput.ini" %PATCHFOLDER%%PATCHFILE12%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE8%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE9%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE10%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE11%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE12%  >>%LOGFOLDER%/patch.log
 


IF "X%COPYCONFIGFILES%"=="X1"  echo Copying config files from configs\* to %APBPATH%\apbgame\config\
IF "X%COPYCONFIGFILES%"=="X1" copy configs\*  %APBPATH%\apbgame\config\ /y
IF "X%MAKEREADONLY%"=="X1" GOTO MAKEREADONLY
goto RUNAPB
GOTO EXIT

:MAKEREADONLY
echo Making Engine and APBgame config files readonly.
attrib  +r "%APBPATH%\Engine\Config\BaseEngine.ini" 
attrib  +r "%APBPATH%\APBGame\Config\APBEngine.ini"
attrib  +r "%APBPATH%\APBGame\Config\APBCompat.ini"
attrib  +r "%APBPATH%\APBGame\Config\APBCompat_Dev.ini"
attrib  +r "%APBPATH%\Engine\Config\BaseInput.ini" 
attrib  +r "%APBPATH%\APBGame\Config\APBInput.ini"
attrib  +r "%APBPATH%\APBGame\Config\DefaultInput.ini"
goto RUNAPB
GOTO EXIT

:NOINI
echo settings.ini not found!
GOTO EXIT

:EXIT
echo Goodbye.