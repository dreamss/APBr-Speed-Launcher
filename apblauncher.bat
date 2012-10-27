@echo off
IF NOT EXIST "settings.ini" GOTO NOINI
for /f "tokens=1,2 delims==" %%a in (settings.ini) do ( 
set %%a=%%b
) 




set PATCHFOLDER=patches\
set LOGFOLDER=log\

ECHO KILLING VIVOX!
TASKKILL /F /IM VivoxVoiceService.exe
IF EXIST "C:\Users\dreamss"  set APBPATH=d:\apb
IF NOT EXIST "%APBPATH%\Binaries\Apb.exe" GOTO NOAPBDIR
IF EXIST "C:\Users\dreamss" GOTO DREAMSSAREA

IF "X%DELETEINTROMOVIES%"=="X1" GOTO RENTRASH
goto PATCHCONFIGS
GOTO EXIT

:DREAMSSAREA
echo Setting up dreamss custom settings..
set MAKEREADONLY=1
set COPYCONFIGFILES=0
set DISABLEALTTAB=1
set SETAFFINITY=1
set AFFINITYBIT=55
set DELAYWAITTIMER=30000
set APBPATH=d:\apb
GOTO RENTRASH
 
:DISABLEALTTAB
cls
echo WAITING  %DELAYWAITTIMER%ms then DISABLING ALT TAB!
PING 1.1.1.1 -n 1 -w %DELAYWAITTIMER% >NUL
 tools\disablealttab.bat
GOTO EXIT

:RENTRASH
echo Deleting movies..


IF EXIST "%APBPATH%\APBGame\Movies\SplashScreen.bik" echo.  > "%APBPATH%\APBGame\Movies\SplashScreen.bik"
IF EXIST "%APBPATH%\APBGame\Movies\IntroTitles.bik" echo.  > "%APBPATH%\APBGame\Movies\IntroTitles.bik"
IF EXIST "%APBPATH%\APBGame\Movies\EnfTutorial.bik" echo.  > "%APBPATH%\APBGame\Movies\EnfTutorial.bik"
IF EXIST "%APBPATH%\APBGame\Movies\CrimTutorial.bik" echo.  > "%APBPATH%\APBGame\Movies\CrimTutorial.bik"
IF EXIST "%APBPATH%\APBGame\Movies\APBFirstSpawnTutorial.bik" echo.  > "%APBPATH%\APBGame\Movies\APBFirstSpawnTutorial.bik"

goto PATCHCONFIGS

:NOAPBDIR
echo ERROR!
echo "%APBPATH%\Binaries\Apb.exe" not found! 
echo Please edit APBPATH. THANKYOU!
echo.
pause
GOTO EXIT

:RUNAPB
IF "X%SETAFFINITY%"=="X1" GOTO RUNAPBAFFINITY
echo Starting APBr!
start /d  "%APBPATH%\Binaries\" Apb.exe 
IF "X%DISABLEALTTAB%"=="X1" GOTO DISABLEALTTAB
GOTO EXIT

:RUNAPBAFFINITY
echo Starting APBr and settin affinty to %AFFINITYBIT%!
start /affinity %AFFINITYBIT% /d   "%APBPATH%\Binaries\" Apb.exe  
IF "X%DISABLEALTTAB%"=="X1" GOTO DISABLEALTTAB
GOTO EXIT

:PATCHCONFIGS
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
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE8%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE9%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE10%  >>%LOGFOLDER%/patch.log


patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\DefaultInput.ini" %PATCHFOLDER%%PATCHFILE12%  >>%LOGFOLDER%/patch.log
patch --no-backup-if-mismatch -f -s -t -N --reject-file="%LOGFOLDER%/rej" "%APBPATH%\APBGame\Config\APBInput.ini" %PATCHFOLDER%%PATCHFILE11%  >>%LOGFOLDER%/patch.log

echo Copying config files from configs\* to %APBPATH%\apbgame\config\
copy configs\*  %APBPATH%\apbgame\config\ /y
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