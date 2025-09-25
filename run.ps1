# 新增文件：start-client-and-nginx.ps1
# Purpose: fire-and-forget start for frp client (via client_connect.bat) and nginx, then exit.
# Notes:
#   - No exit-code checks per requirement.
#   - Hidden windows, detached from current PowerShell session.
#   - WorkingDirectory is explicitly set to ensure relative paths like -p "." resolve as intended.

# resolve script root (repo root)
$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition # This is compatible with PowerShell v2.0+

# compose working directories
$ClientDir = Join-Path $ScriptDir 'client'
$NginxDir  = Join-Path $ScriptDir 'nginx-1.29.1'

# start frp client batch in background (hidden)
Start-Process -FilePath 'cmd.exe' `
  -ArgumentList @('/c', 'client_connect.bat') `
  -WorkingDirectory $ClientDir `
  -WindowStyle Hidden

# start nginx in background (hidden) with the specified config
$NginxExe = Join-Path $NginxDir 'nginx.exe'
Start-Process -FilePath $NginxExe `
  -ArgumentList @('-p', '.', '-c', 'conf\nginx.conf') `
  -WorkingDirectory $NginxDir `
  -WindowStyle Hidden

# exit immediately; background processes keep running
exit 0