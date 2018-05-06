Param (
    [Parameter(Mandatory=$True)]
    [string]$365DynamicDistributionGroupName
)

$dldetails = Get-DynamicDistributionGroup $365DynamicDistributionGroupName
$members = Get-Recipient -RecipientPreviewFilter $dldetails.RecipientFilter -ResultSize unlimited | foreach {$_.Name}

#OUTPUT
echo "=========== ======== ======== ==========="
echo "*   DYNAMIC DISTRIBUTION GROUP MEMBERS  *"
echo ""
echo $members
echo ""
echo "====== END OF OUTPUT ======"


