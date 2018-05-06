Param (
    [Parameter(Mandatory=$True)]
    [string]$username_with_domain,
    [Parameter(Mandatory=$True)]
    [string]$password
    )

$SecPaswd= ConvertTo-SecureString –String $($password) –AsPlainText –Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $($username_with_domain), $SecPaswd
$mySession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $cred -Authentication Basic -AllowRedirection
Import-PSSession $mySession




