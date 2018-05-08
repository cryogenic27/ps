Param (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [AllowEmptyString()]
    [string]$sharedmailbox_with_domain
    )


set-mailbox $sharedmailbox_with_domain -MessageCopyForSentAsEnabled $True -Force
set-mailbox $sharedmailbox_with_domain -MessageCopyForSendOnBehalfEnabled $True -Force

$result = Get-Mailbox $sharedmailbox_with_domain |select-object Alias,PrimarySMTPAddress,MessageCopyForSentAsEnabled,MessageCopyForSendOnBehalfEnabled

echo "==================================================="
echo ""
echo "Getting Sent Items Config for $sharedmailbox_with_domain"
echo "Alias: $($result.Alias)"
echo "Email Address: $($result.PrimarySMTPAddress)"
echo "Allow Send As delegates to send emails to their sent items: $($result.MessageCopyForSentAsEnabled)"
echo "Allow Send On Behalf delegates to send emails to their sent items: $($result.MessageCopyForSendOnBehalfEnabled)"
echo ""
echo "==================================================="
