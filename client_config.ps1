(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName "localhost" -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0)
$lijst=Get-WinUserLanguageList
$lijst.insert(0, 'nl-BE')
Set-WinUserLanguageList $lijst -Force
New-PSDrive -Name HKU -PSProvider Registry -Scope Global -Root HKEY_USERS
Set-ItemProperty -Path "HKU:\.Default\Keyboard Layout\preload" -Name 1 -Value "00000813"
