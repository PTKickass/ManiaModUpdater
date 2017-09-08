@echo on
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
set color=color
set not_support=not_support
set updater=updater

::Backs up and Removes DevkitPro from PATH
set oldPATH=%PATH%
path %oldPATH:c:\devkitPro\msys\bin;=% >nul

setLocal EnableDelayedExpansion
find /i "IsEnableColours=false" ManiaModUpdater.config
if %errorlevel% EQU 0 (set color=no)

find /i "IsSkipSupportCheck=True" ManiaModUpdater.config
if %errorlevel% EQU 0 (set not_support=updater)

find /i "IsSkipToolUpdater=true" ManiaModUpdater.config
if %errorlevel% EQU 0 (goto begin)

find /i "IsDebugEnable=true" ManiaModUpdater.config
if %errorlevel% EQU 0 (set updater=debug_menu)


cls
md _modupdater
attrib +h _modupdater
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Checking for updates...

for /F "skip=3 delims=" %%1 in (ManiaModUpdater.config) do if not defined mmupd set "mmupd=%%1"
powershell "($WebClient = New-Object System.Net.WebClient).DownloadFile('%mmupd%', '_modupdater/ManiaModUpdater.config')"
setLocal EnableDelayedExpansion
set "install="
for /F "skip=1 delims=" %%2 in (ManiaModUpdater.config) do if not defined install set "install=%%2"

set "download="
for /F "skip=1 delims=" %%3 in (_modupdater/ManiaModUpdater.config) do if not defined download set "download=%%3"

if /I "%install%" LSS "%download%" (goto mmupd_update)
goto begin

:mmupd_update
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo ManiaModUpdater has a new update!
echo.
echo Getting Changelog...

for /F "skip=5 delims=" %%6 in (ManiaModUpdater.config) do if not defined mmi_change set "mmi_change=%%6"
powershell "($WebClient = New-Object System.Net.WebClient).DownloadFile('%mmi_change%', '_modupdater/changelog.log')"
if exist "_modupdater/changelog.log" (goto mmiupd_ready_changes)
goto mmiupd_ready_nochanges


:mmuupd_update
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo ManiaModUpdater has a new update!
echo.
echo Changelog:
type "_modupdater\changelog.log"
echo.
echo Would you like to download and install the update?
set /p mmupd_update=(Y/N)
if /I %mmupd_update% EQU Y (goto mmupd_update_yes)
if /I %mmupd_update% EQU N (goto begin)
goto :mmupd_update


:mmiupd_ready_nochanges
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo ManiaModUpdater has a new update!
echo.
echo No Changelog available
echo.
echo Would you like to download and install the update?
set /p mmupd_update=(Y/N)
if /I %mmupd_update% EQU Y (goto mmupd_update_yes)
if /I %mmupd_update% EQU N (goto begin)
goto :mmupd_update

:mmupd_update_yes
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 0%
echo ²²²²²²²²²²²²²²²²²²²²
echo ------------------------------------------
echo Updating ManiaModUpdater...
echo This may take a while, please wait...


md "_modupdater\update"
setLocal EnableDelayedExpansion


cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 5%
echo Û²²²²²²²²²²²²²²²²²²²
echo ------------------------------------------
echo Updating ManiaModUpdater...
echo This may take a while, please wait...

powershell "($WebClient = New-Object System.Net.WebClient).DownloadFile('https://github.com/PTKickass/ManiaModUpdater/blob/master/ManiaModUpdater.zip?raw=true', '_modupdater/update/update.zip')"


cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 40%
echo ÛÛÛÛ²²²²²²²²²²²²²²²²
echo ------------------------------------------
echo Updating ManiaModUpdater...
echo This may take a while, please wait...

powershell "($WebClient = New-Object System.Net.WebClient).DownloadFile('https://github.com/PTKickass/ManiaModUpdater/blob/master/Dependencies/7z.exe?raw=true', '_modupdater/update/7z.exe')"

cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 60%
echo ÛÛÛÛÛÛÛÛÛÛÛÛ²²²²²²²²
echo ------------------------------------------
echo Updating ManiaModUpdater...
echo This may take a while, please wait...


md "_modupdater\update\extract"
cls


echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 80%
echo ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²²²²
echo ------------------------------------------
echo Updating ManiaModUpdater...
echo This may take a while, please wait...


_modupdater\update\7z.exe x "_modupdater\update\update.zip" -o"_modupdater\update\extract" -y>nul


cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 95%
echo ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²
echo ------------------------------------------
echo Updating ManiaModUpdater...
echo This may take a while, please wait...


xcopy /s /y /h "_modupdater\update\extract" .\


cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 100%
echo ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo ------------------------------------------
echo Updating ManiaModUpdater...
echo This may take a while, please wait...

RD /S /Q _modupdater
timeout /t 2 /nobreak>nul

cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Update finished!
echo ManiaModInstaller will now close. Press any key and please re-open the tool.
pause>nul
goto end

::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:begin
RD /S /Q _modupdater
cls
cd Mods
cls
%color% 7
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo 		Main Menu
echo ------------------------------------------
echo Mods with apparent update support:
echo.
for /r %%a in (.) do @if exist "%%~fa\mod_updater.ini" echo %%~nxa
echo.
echo.
echo Type the mod's name to update that mod
echo Type "refresh" to refresh the mod list
echo Type "exit" to exit the mod updater
echo.
echo ------------------------------------------
set /p mod=
if /I "%mod%" EQU "refresh" goto begin
if /I "%mod%" EQU "" goto begin
if /I "%mod%" EQU "exit" goto end

cd "%mod%"
for %%9 in (.) do (set currentmod=%%~nx9)
rd /s /q temp
setLocal EnableDelayedExpansion
find /i "IsEnableDebug=true" mod_updater.ini
if %errorlevel% EQU 0 (goto debug_menu)

setLocal EnableDelayedExpansion
find /i "IsUpdaterSupport=false" mod_updater.ini
if %errorlevel% EQU 0 (goto %not_support%)
goto %updater%

:not_support
cls
%color% C
echo ------------------------------------------
echo 		ERROR
echo ------------------------------------------
echo ERROR: This mod doesn't support auto-updates
echo Returning to main menu...
echo.
echo Note: If this is your mod, be sure to add
echo "IsUpdaterSupport=true" to mod_updater.ini!
echo.
echo ------------------------------------------
timeout /t 3 /nobreak>nul
goto begin

:debug_menu
%color% 1E
cls
echo ------------------------------------------------------
echo 	     Debug Menu for %currentmod%
echo ------------------------------------------------------
echo.
echo 1 - Print UpdFile url
echo 2 - Print UpdIni url
echo 3 - Print UpdChangelog url
echo 4 - Proceed update and bypass compatibility checks
echo "exit" will exit the debug menu
set /p debug_choice=

if /I %debug_choice% EQU 1 (goto debug_updfile)
if /I %debug_choice% EQU 2 (goto debug_updini)
if /I %debug_choice% EQU 3 (goto debug_updchange)
if /I %debug_choice% EQU 4 (goto updater)
if /I %debug_choice% EQU exit (goto begin)

goto :debug_menu


:debug_updfile
setLocal EnableDelayedExpansion
for /F "skip=12 delims=" %%f in (mod.ini) do if not defined updserv_file set "updserv_file=%%f"
echo.
echo URL=%updserv_file%
pause>nul
goto debug_menu

:debug_updini
setLocal EnableDelayedExpansion
for /F "skip=8 delims=" %%u in (mod.ini) do if not defined updserv_ini set "updserv_ini=%%u"
echo.
echo URL=%updserv_ini%
pause>nul
goto debug_menu

:debug_updchange
setLocal EnableDelayedExpansion
for /F "skip=10 delims=" %%m in (mod.ini) do if not defined updserv_change set "updserv_change=%%m"
echo.
echo URL=%updserv_change%
pause>nul
goto debug_menu

::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
:updater
color 7
RD /S /Q temp
md temp
attrib +h temp
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Checking update availability for "%currentmod%"

setLocal EnableDelayedExpansion
for /F "skip=8 delims=" %%u in (mod.ini) do if not defined updserv_ini set "updserv_ini=%%u"
powershell "($WebClient = New-Object System.Net.WebClient).DownloadFile('%updserv_ini%', 'temp/mod.ini')"

setLocal EnableDelayedExpansion
set "install="
for /F "skip=3 delims=" %%i in (mod.ini) do if not defined install set "install=%%i"

set "download="
for /F "skip=3 delims=" %%d in (temp\mod.ini) do if not defined download set "download=%%d"

if /I "%install%" LSS "%download%" (goto update_ready_getchanges)

cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo You already have the latest version installed
echo Going back to the Main Menu...
RD /s /q temp
timeout /t 2 /nobreak>nul
goto begin


:update_ready_getchanges
del /q temp\changelog.log
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Update available!
echo Getting changelog, please wait...
setLocal EnableDelayedExpansion
for /F "skip=10 delims=" %%m in (mod.ini) do if not defined updserv_change set "updserv_change=%%m"
powershell "($WebClient = New-Object System.Net.WebClient).DownloadFile('%updserv_change%', 'temp/changelog.log')"
if exist "temp/changelog.log" (goto update_ready_changes)
goto update_ready_nochanges

:update_ready_changes
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Update available!
echo Changelog:
echo.
type "temp\changelog.log"
echo.
echo Update "%currentmod%"?
set /p updconfirm=(Y/N)
if /I "%updconfirm%" EQU "Y" (goto update_mod)
if /I "%updconfirm%" EQU "N" (goto begin)
goto update_ready_changes

:update_ready_nochanges
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Update available!
echo No changelog available.
echo.
echo Update "%currentmod%"?
set /p updconfirm_nochange=(Y/N)
if /I "%updconfirm_nochange%" EQU "Y" (goto update_mod)
if /I "%updconfirm_nochange%" EQU "N" (goto begin)
goto update_ready_nochanges

::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:update_mod
RD /S /Q "temp/update"
RD /S /Q "temp/update/extract"
cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 0%
echo ²²²²²²²²²²²²²²²²²²²²
echo ------------------------------------------
echo Updating "%currentmod%"...
echo This may take a while, please wait...


md "temp\update"
setLocal EnableDelayedExpansion


cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 5%
echo Û²²²²²²²²²²²²²²²²²²²
echo ------------------------------------------
echo Updating "%currentmod%"...
echo This may take a while, please wait...

setLocal EnableDelayedExpansion
for /F "skip=12 delims=" %%f in (mod.ini) do if not defined updserv_file set "updserv_file=%%f"
powershell "($WebClient = New-Object System.Net.WebClient).DownloadFile('%updserv_file%', 'temp/update/update.zip')"


cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 40%
echo ÛÛÛÛ²²²²²²²²²²²²²²²²
echo ------------------------------------------
echo Updating "%currentmod%"...
echo This may take a while, please wait...

powershell "($WebClient = New-Object System.Net.WebClient).DownloadFile('https://github.com/PTKickass/ManiaModUpdater/blob/master/Dependencies/7z.exe?raw=true', 'temp/update/7z.exe')"

cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 60%
echo ÛÛÛÛÛÛÛÛÛÛÛÛ²²²²²²²²
echo ------------------------------------------
echo Updating "%currentmod%"...
echo This may take a while, please wait...


md "temp\update\extract"
cls


echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 80%
echo ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²²²²
echo ------------------------------------------
echo Updating "%currentmod%"...
echo This may take a while, please wait...


temp\update\7z.exe x "temp\update\update.zip" -o"temp\update\extract" -y>nul


cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 95%
echo ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²
echo ------------------------------------------
echo Updating "%currentmod%"...
echo This may take a while, please wait...


xcopy /s /y /h "temp\update\extract" .\


cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Progress 100%
echo ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo ------------------------------------------
echo Updating "%currentmod%"...
echo This may take a while, please wait...

RD /S /Q temp
timeout /t 2 /nobreak>nul

cls
echo Sonic Mania Mod Updater v1.3
echo By PTKickass
echo ------------------------------------------
echo Update finished!
echo Going back to the main menu...
timeout /t 2 /nobreak>nul
goto begin


:end

:: Restores PATH
:: NOTE: This doesn't seem to work after the script ends
path %oldPATH%
