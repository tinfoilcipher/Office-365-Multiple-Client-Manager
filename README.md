Office 365 Multiple Client Manager - 2017 tinfoilcipher
# Manage Multiple Clients via Office 365 Powershell from a single shell

## OUTLINE</br>
The intention of this script is for sysadmins who manage several clients in Office 365 and to save the hassle of creating
manual connections to each tenancy every time a session is required.</br>
</br>
The script reads data from a csv file which must be saved as lookuptable.csv with the headings</br>
cryptstring,CompanyName,username,Selection</br>
</br>
The values are as follows:</br>
**cryptstring**: A PowerShell SecureString encrypted value generated from the password used to connect the session</br>
**CompanyName**: A human readable field to display the name of the client you are connecting to</br>
**username**: The username that corresponds to the passwords that the cryptstring SecureString was generated from</br>
**Selection**: An integer from 0-X (depending on the amount of clients you have)</br>
</br>
## PREREQUISITES</br>
Powershell v2 or higher</br>
Modules for import for MSOL, LyncOnline</br>
</br>
## GENERATING SECURE STRINGS</br>
Included in a short script "encrypted_string_generation.ps1" which, when run, will generate a text file containing an encrypted
string generated against the password being used for connection. Since the strings are being encrypted with the -Key option the
output can be moved between workstations and/or over a network.</br>
</br>
## USE</br>
Run "365Manager.ps1" and you will be prompted with a menu of 0 -X (depending on your configuration) and asked to enter the
corresponding input for the client in question. Attempts to enter outside of range will cause an error routine.</br>
</br>
After entering the relevant credentials will be pulled from the lookup table and you will be prompted for a session type to
initiate which triggers one or all of the functions to connect to Exchange Online, Skype Online or AzureAD. Entering outside of
range will cause an error to be thrown.</br>
</br>
Should a client not have any of these shells, a generic error will be thrown.</br>
