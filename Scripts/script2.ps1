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


### FUNCTIONS
##

## Adds users from CSV file.
##
function AddUsers {
   foreach ($u in $inputFile) {
       $dsn = "CN=" + $u.USERNAME + ",CN=Users,DC=groupB,DC=sqrawler,DC=com"
       dsadd user $dsn -samid $u.USERNAME -fn $u.FIRSTNAME -ln $u.LASTNAME -pwd $u.PASSWORD
   }
}

## Deletes users from CSV file.
##
function DeleteUsers {
   foreach ($u in $inputFile) {
       $dsn = "CN=" + $u.USERNAME + ",CN=Users,DC=groupB,DC=sqrawler,DC=com"
       dsrm $dsn
   }
}



## Adds users from CSV
##
AddUsers

## Deletes users from CSV
##
#DeleteUsers

