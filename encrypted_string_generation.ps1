# Generate Secure String for 365 Connection - tinfoilcipher 2017
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-6

Clear-Host
Write-Host "Enter Client Name (One Word Works Best)"
$strClient = Read-Host ">"
Write-Host "Enter Password to Be Encrypted Below"
$strSecure = Read-Host -AsSecureString
$strOutput = ($strClient + "EncryptedString.txt")
$strEncrypted = ConvertFrom-SecureString -SecureString $strSecure -Key (1..16)
$strEncrypted | Set-Content $strOutput

Write-Host ""
Write-Host "Encrypted string has been saved to" $strOutput "- Copy the output to the lookup table and destroy the output file."
