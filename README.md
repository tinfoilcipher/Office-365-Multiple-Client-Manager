Office 365 Multiple Client Manager - 2017 tinfoilcipher

---OUTLINE---
The intention of this script is for sysadmins who manage several clients in Office 365 and to save the hassle of creating
manual connections to each tenancy every time a session is required.

The script reads data from a csv file which must be saved as lookuptable.csv and formatted as:

cryptstring,CompanyName,username,Selection
128fh03nfl,contoso,admin@contoso.com,0
rf28943fn4,interslice,admin@interslice.co.uk,1
3223f2393,canonical,root@canonical.com,2

The values are as follows:
-cryptstring: A PowerShell SecureString encrypted value generated from the password used to connect the session
-CompanyName: A human readable field to display the name of the client you are connecting to
-username: The username that corresponds to the passwords that the cryptstring SecureString was generated from
-Selection: An integer from 0-X (depending on the amount of clients you have)

---GENERATING SECURE STRINGS---
Included in a short script "encrypted_string_generation.ps1" which, when run, will generate a text file containing an encrypted string generated against the password being used for connection. Since the strings are being encrypted with the -Key option the output can be moved between workstations and/or over a network.

---USE---
Run "365Manager.ps1" and you will be prompted with a menu of 0 -X (depending on your configuration) and asked to enter the corresponding input for the client in question. Attempts to enter outside of range will cause an error routine.

After entering the relevant credentials will be pulled from the lookup table and you will be prompted for a session type to initiate which triggers one or all of the functions to connect to Exchange Online, Skype Online or AzureAD. Entering outside of range will cause an error to be thrown.

Should a client not have any of these shells, a generic error will be thrown.
