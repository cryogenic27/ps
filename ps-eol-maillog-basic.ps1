
Param (
    [Parameter(Mandatory=$True)]
    [string]$senderEmailAddress,
    [Parameter(Mandatory=$True)]
    [string]$hours_to_track_back

    )


$dateEnd = get-date 
$dateStart = $dateEnd.AddHours($("-" + $hours_to_track_back))
 
    $message = Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd -SenderAddress $senderEmailAddress -Pagesize 5000 -Page 1 `
    | Select-Object Received,SenderAddress,RecipientAddress,Subject,Status


echo ""
echo ""
echo "===== ===== ===== ====== ====="
echo "Basis: SENDER -> $senderEmailAddress"
echo "Back tracking $hours_to_track_back hour(s) from present."
echo "... ..."
echo "Begin Mail Delivery Log"
echo ""
echo "Received,SenderAddress,RecipientAddress,Subject,Status"
foreach($x in $message)
{

  $($($x.Status)+"`t"+$($x.Received)+"`t"+$($x.RecipientAddress)+"`t"+$($x.Subject))

}

echo ""
echo "===== ===== END OF OUTPUT ====== ====="


