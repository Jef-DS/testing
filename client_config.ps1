param(
    [string]$pwd,
    [string]$username = 'administrator'
)
$securepawd = ConvertTo-SecureString $pwd -AsPlainText -Force
New-LocalUser $username -Password $securepawd -Description "Beheerder"
Add-LocalGroupMember -Group "Administrators" -Member $username
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName "localhost" -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0)
$lijst=Get-WinUserLanguageList
$lijst.insert(0, 'nl-BE')
Set-WinUserLanguageList $lijst -Force
New-PSDrive -Name HKU -PSProvider Registry -Scope Global -Root HKEY_USERS
Set-ItemProperty -Path "HKU:\.Default\Keyboard Layout\preload" -Name 1 -Value "00000409"
Set-ItemProperty -Path "HKU:\.Default\Keyboard Layout\preload" -Name 2 -Value "00000813"