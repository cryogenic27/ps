#GET INFORMATION OF STORAGE DRIVES IN THE SYSTEM
$hdd = get-WmiObject win32_logicaldisk -Computername localhost

#SET VALUES FOR THE VARIABLES USED IN THIS SCRIPT
#DESIGNATED DESTINATION OF LOGS
$logpath = "C:\logs\"
#PATH TO MONITOR AND TO DELETE OLD LOG FILES FROM
#IN THIS EXAMPLE, I AM DELETING OLD EVENT LOG FILES
$path = "C:\Windows\System32\winevt\Logs\"

#DECLARATION OF FUNCTIONS
function fn_getdate
{
 #THIS FUNCTION GETS THE DATE VALUES 
 #FORMAT DATE TO BE USED IN LOG FILES
 $dd = get-date
 $yy = $dd.Year
 $mm = $dd.Month
 $d1 = $dd.Day
 $hh = $dd.Hour
 $m1 = $dd.Minute
 $ss = $dd.Second
 $logdate = $("$yy"+"$mm"+"$d1"+"-"+"$hh"+":"+"$m1"+":"+"$ss"+"PHT")
}

#CHECK IF LOGFILE ALREADY EXISTS
#CALL THE FUNCTION TO GET DATE
fn_getdate

#SET THE FILENAME AND THE PATH TO BE USED
$logfile = $("$yy" + "$mm" + "_drivecmaint.csv")
$logfile = $($logpath+$logfile)

#CHECK IF THE FILENAME EXISTS
#THIS IS ASSUMING THE DIRECTORY IS EXISTING
$checklogfile = [System.IO.File]::Exists($logfile)
#IF LOG FILE IS NOT YET EXISTING, CREATE
if (!$checklogfile)
{
  New-Item $logfile
  "Date,FileAge,FileName,Remarks" | Add-Content $logfile
}

#USING FOREACH LOOP TO PROCESS ALL OUTPUTS OF CHECKING THE HARD DRIVE
foreach($h in $hdd)
{
 #CHECK IF THE ENTRY BEING PROCESSED IS
 #DRIVE = C:, DRIVE TYPE = LOCAL HARD DISK (3)
 if($h.DeviceID -eq "C:" -AND $h.DriveType -eq "3")
 {
  echo "CHECKING FREE SPACE FOR DRIVE C:"
  $percentfree = (($h.FreeSpace / $h.Size)*100)
  $percentused = 100 - $percentfree
  $size = ((($h.Size / 1024)/1024)/1024)

  #IF FREE SPACE IS LESS THAN 30%, FREE UP
  if($percentfree -lt 30.00){ 

  #GO TO DIRECTORY FROM WHERE OLD FILES NEED TO GET DELETED
  cd $path
  $file_evt = dir

  #SINCE IN THIS EXAMPLE, I AM DELETING ARCHIVED SECURITY LOGS...
  foreach($f in $file_evt)
  {
    #ONLY IF FILENAME CONTAINS THIS KEYWORD...
    if ($f.Name -like 'Archive-Security*')
    {
     $f | fl
     $d = get-date
     $fc = $f.CreationTime
     $age = $d - $fc
     $age = $age.Days

    if($age -gt 10)
    {
     fn_getdate
     #DELETING EVENT LOG FILE
     Remove-Item $f.Name
     #CREATING LOG ENTRY
     $log = $($logdate+","+$age+","+$f.Name+","+"DELETING OLD FILES (SCHEDULED TASK)")
     #ADDING LOG ENTRY TO FILE
     $log | Add-Content $logfile
    }
   }
  }
 }
}
}

if($percentfree -ge 30.00)
{
 fn_getdate
 #CREATING LOG ENTRY
 $log = $($logdate+",0,0,NO EVTX FILES OLDER THAN 10 DAYS FOUND (SCHEDULED TASK)")
 #ADDING LOG ENTRY TO FILE
 $log | Add-Content $logfile
}