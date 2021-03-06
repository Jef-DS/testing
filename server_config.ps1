﻿param(
    [string]$pwd,
    [string]$username = 'administrator'
)
Get-LocalUser "administrator" -ErrorVariable isnotadmin -ErrorAction SilentlyContinue
if (-not $isnotadminadmin){
	$securepawd = ConvertTo-SecureString $pwd -AsPlainText -Force
	New-LocalUser $username -Password $securepawd -Description "Beheerder"
	Add-LocalGroupMember -Group "Administrators" -Member $username
}
<#$cred = New-Object System.Management.Automation.PSCredential($username, $securepwd)
try{
    Start-Process -FilePath "cmd.exe" -LoadUserProfile -Credential $cred -ArgumentList "/c"
}catch{
    Write-Error "verwachte fout in Start-Process"
}#>
$localhost = $env:COMPUTERNAME
$computer = "client" + $localhost.substring($localhost.length-3, 3)
$rdp = @"
screen mode id:i:1
use multimon:i:0
desktopwidth:i:1024
desktopheight:i:768
session bpp:i:32
winposstr:s:0,3,0,0,800,600
compression:i:1
keyboardhook:i:2
audiocapturemode:i:0
videoplaybackmode:i:1
connection type:i:7
networkautodetect:i:1
bandwidthautodetect:i:1
displayconnectionbar:i:1
enableworkspacereconnect:i:0
disable wallpaper:i:0
allow font smoothing:i:0
allow desktop composition:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:0
disable cursor setting:i:0
bitmapcachepersistenable:i:1
full address:s:$computer
audiomode:i:0
redirectprinters:i:0
redirectcomports:i:0
redirectsmartcards:i:1
redirectclipboard:i:1
redirectposdevices:i:0
autoreconnection enabled:i:1
authentication level:i:2
prompt for credentials:i:0
negotiate security layer:i:1
remoteapplicationmode:i:0
alternate shell:s:
shell working directory:s:
gatewayhostname:s:
gatewayusagemethod:i:4
gatewaycredentialssource:i:4
gatewayprofileusagemethod:i:0
promptcredentialonce:i:0
gatewaybrokeringtype:i:0
use redirection server name:i:0
rdgiskdcproxy:i:0
kdcproxyname:s:
drivestoredirect:s:
enablecredsspsupport:i:0
"@

$path = "${env:PUBLIC}\Desktop\client.rdp"
$rdp | Set-Content $path
