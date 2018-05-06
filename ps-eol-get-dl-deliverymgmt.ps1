Param (
    [Parameter(Mandatory=$True)]
    [string]$365DistributionGroup
)

$details = Get-DistributionGroup -identity $365DistributionGroup | select -ExpandProperty AcceptMessagesOnlyFromSendersOrMembers

#OUTPUT
echo "=========== ======== ======== ==========="
echo "* DISTRIBUTION GROUP PERMITTED SENDERS *"
echo ""

echo "Group Name / Alias: $365DistributionGroup"
echo ""
echo $details
echo ""
echo "====== END OF OUTPUT ======"


