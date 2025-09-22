@echo off
cd /d %~dp0
echo 正在启动 frpc...
frpc.exe -c frpc.ini
pause
