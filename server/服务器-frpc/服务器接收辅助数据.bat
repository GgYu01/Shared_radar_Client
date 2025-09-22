@echo off
cd /d %~dp0
echo 正在启动 frpc...
frps.exe -c frps.toml
pause
