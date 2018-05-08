
Param (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyString()]
    [string]$sharedmailbox_with_domain,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyString()]
	[string]$delegate_with_domain
    )

$result1 = Get-MailboxPermission -Identity $sharedmailbox_with_domain | ft identity,user,accessrights | Out-String
$result2 = $result1.Split([Environment]::NewLine)

Echo "============= DELEGATED USERS BEFORE REMOVAL ============="
    foreach($x in $result2){
        if($x -like "*@*"){echo $x}
    }

Echo "============= END OF DELEGATED USERS BEFORE REMOVAL ============="
echo ""
echo "... ... ... REMOVING DELEGATION ... ... ... "
echo ""

Get-Mailbox -identity $($shared+"@concentrix.com") | `
remove-MailboxPermission -User $($delegate+"@concentrix.com") -AccessRights FullAccess

$result1 = Get-MailboxPermission -Identity $sharedmailbox_with_domain | ft identity,user,accessrights | Out-String
$result2 = $result1.Split([Environment]::NewLine)

Echo "============= DELEGATED USERS AFTER REMOVAL ============="
    foreach($x in $result2){
        if($x -like "*@*"){echo $x}
    }

Echo "============= END OF ELEGATED USERS AFTER REMOVAL ============="
