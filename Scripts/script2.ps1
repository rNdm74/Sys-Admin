## Example PowerShell script profile
##   by: Adam Charlton
## date: 19March2013
## Add and delete users 
## 



### VARAIABLES
##
## Import users from CSV file.
##
$inputFile = Import-CSV  users.csv
$DateStamp = get-date -uformat "%Y-%m-%d@%H-%M-%S"


### FUNCTIONS
##

## Creates log file of added or removed users.
##
function LogFile($n){   
   $logFile = New-Item $n -type file -force -value "USERNAME"
   Add-content $logFile -value ' '
   return $logFile
}

## Adds users from CSV file.
##
function AddUsers {
   $logFile = LogFile($DateStamp + '_added.log')
   
   foreach ($u in $inputFile) {
       Add-content $logFile -value $u.USERNAME
       $dsn = "CN=" + $u.USERNAME + ",CN=Users,DC=groupB,DC=sqrawler,DC=com"
       dsadd user $dsn -samid $u.USERNAME -fn $u.FIRSTNAME -ln $u.LASTNAME -pwd $u.PASSWORD
   }
	
   Write-Host "log file created", $DateStamp"_added.log"
}

## Deletes users from CSV file.
##
function DeleteUsers {
   $logFile = LogFile($DateStamp + '_removed.log')

   foreach ($u in $inputFile) {
       Add-content $logFile -value $u.USERNAME
       $dsn = "CN=" + $u.USERNAME + ",CN=Users,DC=groupB,DC=sqrawler,DC=com"
       dsrm -noprompt $dsn
   }

   Write-Host "log file created", $DateStamp"_removed.log"
}



## Adds users from CSV
##
AddUsers

## Deletes users from CSV
##
#DeleteUsers



