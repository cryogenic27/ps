Param (
    [Parameter(Mandatory=$True)]
    [string]$365DistributionGroup
)

$details = Get-DistributionGroup -identity $365DistributionGroup `
|Select-Object IsDirSynced,ManagedBy,Alias,Identity,Name,DisplayName,PrimarySmtpAddress, `
MemberJoinRestriction,MemberDepartRestriction,HiddenFromAddressListsEnabled,RecipientType,WhenCreated

$owners = $details | select -ExpandProperty ManagedBy
$members = Get-DistributionGroupMember -Identity $365DistributionGroup | select -ExpandProperty Name
$sendonbehalf=  Get-RecipientPermission -Identity $365DistributionGroup | Where-Object {(($_.IsInherited -eq $false) -and -not ($_.Trustee -like "NT AUTHORITY\SELF")) -and ($_.Trustee -match '@') }  | %{$_.Trustee} 

#OUTPUT
echo "========== ===== ===== =========="
echo "* DISTRIBUTION GROUP PROPERTIES *"
echo ""

echo "Group Name: $($details.Name)"
echo "Alias: $($details.Alias)"
echo "Identity: $($details.Identity)"
echo "DisplayName: $($details.DisplayName)"
echo "Primary SMTP Address: $($details.PrimarySmtpAddress)"
echo "Recipient Type: $($details.RecipientType)"
echo "Creation Date: $($details.WhenCreated)"
echo "Is synced from OnPremise AD: $($details.IsDirSynced)"
echo ""
echo "Hidden from Address Book: $($details.HiddenFromAddressListsEnabled)"
if($($details.MemberJoinRestriction) -eq 'Closed'){$join="Members can be added only by the group owners. All requests to join will be rejected automatically."}
elseif($($details.MemberJoinRestriction) -eq 'Open'){$join="Anyone can join this group without being approved by the group owners."}
elseif($($details.MemberJoinRestriction) -eq 'Owner approval'){$join="All requests are approved or rejected by the group owners."}
echo "Require Owner Approval for New Members: $join"
if($($details.MemberDepartRestriction) -eq 'Closed'){$leave="Members can be removed only by the group owners. All requests to leave will be rejected automatically."}
elseif($($details.MemberDepartRestriction) -eq 'Open'){$leave="Anyone can leave this group without being approved by the group owners."}
echo "Require Owner Approval for Leaving Members: $leave"
echo ""

echo "========== ===== ===== =========="
echo "*  DISTRIBUTION GROUP MEMBERS   *"
echo ""
echo $members
echo ""

echo "========== ===== ===== =========="
echo "*   DISTRIBUTION GROUP OWNERS   *"
echo ""
echo $owners
echo ""

echo "========== ===== ===== =========="
echo "* DISTRIBUTION GROUP DELEGATION *"
echo ""
echo $sendonbehalf
echo ""
echo "====== END OF OUTPUT ======"


