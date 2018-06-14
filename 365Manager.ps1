#Office 365 Multiple Connector - tinfoilcipher 2017

#Constants
$strLookupTable = Import-CSV lookuptable.csv
[int]$intTabMin = 0
[int]$intTabMax = $strLookuptable.Count - 1

#Functions
function Connect-Exchange {
	$365Esession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $strCredential -Authentication Basic -AllowRedirection
	Import-PSSession $365Esession
}

function Connect-Skype {
	Import-Module LyncOnlineConnector
	$365Lsession = New-CsOnlineSession -Credential $strCredential
	Import-PSSession $365Lsession
}
function Connect-MSOL{
	Import-Module MSOnline
	Connect-MsolService -Credential $strCredential
}

#Select Client
Clear-Host
Foreach ($strLookup in $strLookuptable) {
	Write-Host ($strLookup.Selection + " - " + $strLookup.CompanyName)
}
[int]$intClient = Read-Host ">"
Clear-Host

#Input Error Checking
If ($intClient -lt $intTabMin){
	Write-Host "Cannot enter negative value. Press Return to Exit"
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	$host.SetShouldExit(0)
	exit
}
ElseIf ($intClient -gt $intTabMax){
	Write-Host "Cannot lookup outside of table. Press Return to Exit"
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	$host.SetShouldExit(0)
	exit
}

#Build Connection Paramaters
$strCryptString = $strLookupTable.cryptstring[$intClient]
$strLogon = $strLookupTable.username[$intClient]
$strClient = $strLookupTable.CompanyName[$intClient]
$strPassword = ConvertTo-SecureString -String $strCryptString -Key (1..16)
$strCredential = New-Object System.Management.Automation.PsCredential($strLogon,$strPassword)

#Shell Selection
Clear-Host
Write-Host "Selected client: "$strClient
Write-Host ""
Write-Host "Exchange Online, Skype Online or Azure AD Shell?"
Write-Host "------------------------------------------------"
Write-Host "1 - Exchange Online"
Write-Host "2 - Skype Online"
Write-Host "3 - Azure AD"
Write-Host "4 - ALL OF THE ABOVE"

$strShellType = Read-Host ">"
If ($strShellType -eq "1"){
	Connect-Exchange
}
ElseIf ($strShellType -eq "2"){
	Connect-Skype
}
ElseIf ($strShellType -eq "3"){
	Connect-MSOL
}
ElseIf ($strShellType -eq "4"){
	Connect-Exchange
	Connect-Skype
	Connect-MSOL
}
Else {
	Write-Host ""
	Write-Host "Error Detected. Did you enter a wrong number? Press Return to Exit."
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	$host.SetShouldExit(0)
	exit
}

#END.
