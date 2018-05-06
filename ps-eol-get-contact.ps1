Param (
    [Parameter(Mandatory=$True)]
    [string]$365Contact
)

$details = Get-Contact -identity $365Contact `
|Select-Object DisplayName,RecipientType,WindowsEmailAddress,WhenCreated

#OUTPUT
echo "====== ===== ===== ======"
echo "*   CONTACT PROPERTIES  *"
echo ""
echo "Display Name: $($details.DisplayName)"
echo "Email Addresses: $($details.WindowsEmailAddress)"
echo "RecipientType: $($details.RecipientType)"
echo "Creation Date: $($details.WhenCreated)"
echo ""
echo "====== END OF OUTPUT ======"