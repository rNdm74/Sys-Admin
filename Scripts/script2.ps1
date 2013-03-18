## Example PowerShell script profile
##   by: Adam Charlton
## date: 14March2013
## Add and delete users 
## 



### VARAIABLES
##
## Import users from CSV file.
##
$inputFile = Import-CSV  users.csv




### FUNCTIONS
##

## Returns an array of users.
##
function UserList {
   $userList = $(&dsquery user -samid *)|%{$_.Split("=")[1].replace(",OU","").replace(",CN","")}
   return $userList
}

function AddUsers {
   foreach ($u in $inputFile) {
       #Write-Host $u.USERNAME
       $dsn = "CN=" + $u.USERNAME + ",CN=Users,DC=groupB,DC=sqrawler,DC=com"
       dsadd user $dsn -samid $u.USERNAME -fn $u.FIRSTNAME -ln $u.LASTNAME -pwd $u.PASSWORD
   }
}

function DeleteUsers {
   foreach ($u in $inputFile) {
       #Write-Host $u.USERNAME
       $dsn = "CN=" + $u.USERNAME + ",CN=Users,DC=groupB,DC=sqrawler,DC=com"
       dsrm $dsn
   }
}



## Adds users from CSV
##
#AddUsers

## Deletes users from CSV
##
DeleteUsers

