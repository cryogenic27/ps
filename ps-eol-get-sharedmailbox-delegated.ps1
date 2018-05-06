
Param (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyString()]
    [string]$sharedMailbox
    )

$result2 = @()
$result1 = Get-MailboxPermission -Identity $shared | ft identity,user,accessrights | Out-String
$result2 = $result1.Split([Environment]::NewLine)

Echo "============= DELEGATED USERS ============="
foreach($x in $result2){
    if($x -like "*@*"){
    echo $x
    }
}
Echo "============= END OF RESULT ============="

