REM 10.3.50.39 is my kms server
@echo off

REM GET WINDOWS_VERSION
FOR /F "usebackq tokens=3,4,5,6,7,8" %%a IN (`REG query "hklm\software\microsoft\windows NT\CurrentVersion" /v ProductName`) DO set win_ver=%%a %%b %%c %%d %%e %%f

FOR /F "tokens=1,2,3,4,5,6 delims= " %%a IN ("%win_ver%") DO set win_version=%%a %%b %%c %%d %%e %%f

REM echo %win_version%

REM GET key for current version

if "%win_version%"=="Windows Server 2016 Standard" (
  set key="WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
  GOTO :active_fnc
)

if "%win_version%"== "Windows Server 2016 Datacenter" (
  set key="CB7KF-BWN84-R7R2Y-793K2-8XDDG"
  GOTO :active_fnc
)

if "%win_version%"=="Windows Server 2012 R2 Datacenter" (
  set key="W3GGN-FT8W3-Y4M27-J84CP-Q3VJ9"
  GOTO :active_fnc
)

if "%win_version%"=="Windows 10 Pro" (
  set key="W269N-WFGWX-YVC9B-4J6C9-T83GX"
  GOTO :active_fnc
)

if "%win_ver%"=="Windows Server 2012 R2 Server Standard" (
  set key="D2N9P-3P6X9-2R39C-7RTCD-MDVJX"
  GOTO :active_fnc
)


:active_fnc
slmgr.vbs //b /ipk %key%
slmgr.vbs //b /skms 10.3.50.39
slmgr.vbs //b /ato
echo "%win_version% has been activated"
EXIT /b
