
Param (
    [Parameter(Mandatory=$True)]
    [string]$SenderAddress,
    [Parameter(Mandatory=$True)]
    [string]$Subject,
    [Parameter(Mandatory=$True)]
    [string]$hours_to_track_back

    )


$dateEnd = get-date 
$dateStart = $dateEnd.AddHours($("-" + $hours_to_track_back))
 
    $message = Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd -SenderAddress $SenderAddress -Pagesize 5000 -Page 1 `
    | Select-Object Received,SenderAddress,RecipientAddress,Subject,Status


echo ""
echo ""
echo "===== ===== ===== ====== ====="
echo "Basis: RECIPIENT -> $SenderAddress"
echo "Back tracking $hours_to_track_back hour(s) from present."
echo "... ..."
echo "Begin Mail Delivery Log"
echo "... ..."
echo ""
echo "Status, Received,RecipientAddress,Subject"
foreach($x in $message)
{
    if($($x.Subject) -like "*$Subject*"){
        $($($x.Status)+"`t"+$($x.Received)+"`t"+$($x.RecipientAddress)+"`t"+$($x.Subject))
    }

}

echo ""
echo "===== ===== END OF OUTPUT ====== ====="


