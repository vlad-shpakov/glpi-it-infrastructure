function DriveSpace {
param( [string] $strComputer) 
"$strComputer ---- Free Space (percentage) ----"

# Does the server responds to a ping (otherwise the CIM queries will fail)
$result = Test-connection "$strComputer" -quiet

if ($result) {

   # Get the Disks for this computer
   $colDisks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType = 3"

   # For each disk calculate the free space
   ForEach ($disk in $colDisks) {
      if ($disk.size -gt 0) {
         $PercentFree = [Math]::round((($disk.freespace/$disk.size) * 100))
      }
      else {$PercentFree = 0}

       $Drive = $disk.DeviceID
       "$strComputer - $Drive - $PercentFree"

      if ($PercentFree -le 5) {
	$json = ConvertTo-Json -InputObject @{name = "Espace disque faible - $strComputer - $Drive"; content = "Espace libre restant : $PercentFree %"} -Depth 3

	 Invoke-RestMethod @invokeRestMethodArgs_6efa -Body ([Text.Encoding]::UTF8.GetBytes($json))
          
       }
    }
}
}
# Load saved credentials
$credentials = Import-Clixml "C:\GLPI-Monitor\glpi-credentials.xml"

$clientId = $credentials.OAuth.UserName
$clientSecret = $credentials.OAuth.GetNetworkCredential().Password

$username = $credentials.GLPI.UserName
$password = $credentials.GLPI.GetNetworkCredential().Password



$AuthResponse = Invoke-RestMethod -Uri https://support.hermes.internal/api.php/token -Method "Post" -Body @{grant_type="password"; 
client_id=$clientId; 
client_secret=$clientSecret;
username=$username;
password=$password; 
scope="api"}

$invokeRestMethodArgs_6efa = @{
    Uri = "https://support.hermes.internal/api.php/v2.3/Assistance/Ticket"
    Headers = @{Authorization = "Bearer $($authResponse.access_token)"}
    Method = "Post"
    ContentType = "application/json; charset=utf-8"
}

DriveSpace -strComputer "GLPI-CLIENT"

