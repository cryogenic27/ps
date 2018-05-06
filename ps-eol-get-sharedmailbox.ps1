Param (
    [Parameter(Mandatory=$True)]
    [string]$365SharedMailboxIdentity
)

$details = Get-Mailbox -identity $365SharedMailboxIdentity `
|Select-Object IsShared,Alias,Name,Identity,Displayname,PrimarySmtpAddress,UserPrincipalName, `
WhenMailboxCreated,RecipientType,AccountDisabled,UsageLocation,HiddenFromAddressListsEnabled, `
MaxReceiveSize,MaxSendSize,AuditLogAgeLimit,AuditEnabled,ArchiveWarningQuota,ArchiveQuota, `
ProhibitSendQuota,ProhibitSendReceiveQuota,RecoverableItemsQuota,RecoverableItemsWarningQuota

$permission = Get-MailboxPermission -identity $365SharedMailboxIdentity | ft user,accessrights

#OUTPUT
echo "====== ===== ===== ======"
echo "*  MAILBOX PROPERTIES  *"
echo ""
echo "Is Shared Mailbox: $($details.IsShared)"
echo "Alias: $($details.Alias)"
echo "Name: $($details.Name)"
echo "Identity: $($details.Identity)"
echo "Display Name: $($details.DisplayName)"
echo "Email Addresses: $($details.PrimarySmtpAddress)"
echo "UserPrincipalName: $($details.UserPrincipalName)"
echo "Hidden From Address Book: $($details.HiddenFromAddressListsEnabled)"
echo ""
echo "====== ===== ===== ======"
echo "*  ACCOUNT PROPERTIES  *"
echo ""
echo "Creation Date: $($details.WhenMailboxCreated)"
echo "RecipientType: $($details.RecipientType)"
echo "Disabled: $($details.AccountDisabled)"
echo "UsageLocation: $($details.UsageLocation)"
echo "Audit Log Enabled: $($details.AuditEnabled)"
echo "Audit Log Retention in Days: $($details.AuditLogAgeLimit)"
echo ""
echo "====== ===== ===== ======"
echo "*  MAILBOX LIMITATIONS  *"
echo ""
echo "MaxReceiveSize: $($details.MaxReceiveSize)"
echo "MaxSendSize: $($details.MaxSendSize)"
echo "Archiving Quota Warning in GB: $($details.ArchiveWarningQuota)"
echo "Archiving Quota in GB: $($details.ArchiveQuota)"
echo "User Will not be able to send if mailbox size is more than: $($details.ProhibitSendQuota)"
echo "User Will not be able to send and receive if mailbox size is more than: $($details.ProhibitSendReceiveQuota )"
echo "Recoverable Items Quota Warning in GB: $($details.RecoverableItemsWarningQuota)"
echo "Recoverable Items Quota in GB: $($details.RecoverableItemsQuota)"
echo ""
echo "====== ===== ===== ======"
echo "*  MAILBOX DELEGATION  *"
echo ""
echo $permission
echo "====== END OF OUTPUT ======"