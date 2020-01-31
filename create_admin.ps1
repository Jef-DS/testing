param(
    [string]$pwd,
    [string]$username = 'administrator'
)
$securepawd = ConvertTo-SecureString $pwd -AsPlainText -Force
New-LocalUser "administrator" -Password $securepawd -Description "Beheerder"
Add-LocalGroupMember -Group "Administrators" -Member "administrator"