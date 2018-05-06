Param (
    [Parameter(Mandatory=$True)]
    [string]$365MailUser
)

$details = Get-MailUser -identity $365MailUser `
|Select-Object Alias,DisplayName,Identity,UserPrincipalName,ExternalEmailAddress,PrimarySmtpAddress,RecipientType, `
AccountDisabled,IsDirSynced,HiddenFromAddressListsEnabled,WhenCreated `


#OUTPUT
echo "====== ===== ===== ======"
echo "*   MAILUSER PROPERTIES  *"
echo ""
echo "Alias: $($details.Alias)"
echo "Identity: $($details.Identity)"
echo "DisplayName: $($details.DisplayName)"
echo "UserPrincipalName: $($details.UserPrincipalName)"
echo ""
echo "External Email Address: $($details.ExternalEmailAddress)"
echo "Primary SMTP Address: $($details.PrimarySmtpAddress)"
echo ""
echo "RecipientType: $($details.RecipientType)"
echo "Is Account Disabled: $($details.AccountDisabled)"
echo "Is synce from Onprem Active Directory: $($details.IsDirSynced)"
echo "Is Hidden from Address Book: $($details.HiddenFromAddressListsEnabled)"
echo "When Created: $($details.WhenCreated)"
echo ""
echo "====== END OF OUTPUT ======"