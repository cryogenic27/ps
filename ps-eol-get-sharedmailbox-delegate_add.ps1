
Param (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyString()]
    [string]$sharedmailbox_with_domain,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyString()]
	[string]$delegate_with_domain
    )


Get-Mailbox -identity $sharedmailbox_with_domain | `
Add-MailboxPermission -User $delegate_with_domain -AccessRights FullAccess -InheritanceType all -AutoMapping $True

$result1 = Get-MailboxPermission -Identity $sharedmailbox_with_domain | ft identity,user,accessrights | Out-String
$result2 = $result1.Split([Environment]::NewLine)

Echo "============= DELEGATED USERS ============="
foreach($x in $result2){

    if($x -like "*@*"){
        if($x -like "*$delegate_with_domain*"){
        echo $($x +">>> *** NEWLY ADDED ***")
        }
        else{ echo $x }
    }
    }

Echo "============= END OF RESULT ============="
