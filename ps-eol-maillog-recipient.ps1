
Param (
    [Parameter(Mandatory=$True)]
    [string]$RecipientAddress,
    [Parameter(Mandatory=$True)]
    [string]$hours_to_track_back

    )


$dateEnd = get-date 
$dateStart = $dateEnd.AddHours($("-" + $hours_to_track_back))
 
    $message = Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd -RecipientAddress $RecipientAddress -Pagesize 5000 -Page 1 `
    | Select-Object Received,SenderAddress,RecipientAddress,Subject,Status


echo ""
echo ""
echo "===== ===== ===== ====== ====="
echo "Basis: RECIPIENT -> $RecipientAddress"
echo "Back tracking $hours_to_track_back hour(s) from present."
echo "... ..."
echo "Begin Mail Delivery Log"
echo "... ..."
echo ""
echo "Status, Received,SenderAddress,Subject"
foreach($x in $message)
{

  $($($x.Status)+"`t"+$($x.Received)+"`t"+$($x.SenderAddress)+"`t"+$($x.Subject))

}

echo ""
echo "===== ===== END OF OUTPUT ====== ====="


