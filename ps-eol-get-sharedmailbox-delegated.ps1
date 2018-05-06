
Param (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyString()]
    [string]$sharedMailbox_Alias
    )

$result1 = Get-MailboxPermission -Identity $sharedMailbox_Alias | ft identity,user,accessrights | Out-String
$result2 = $result1.Split([Environment]::NewLine)

Echo "============= DELEGATED USERS ============="
foreach($x in $result2){
    if($x -like "*@*"){
    echo $x
    }
}
Echo "============= END OF RESULT ============="

