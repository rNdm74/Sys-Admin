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



$dsn = "CN=" + $inputfile.USERNAME + ",CN=Users,DC=groupB,DC=sqrawler,DC=com"
dsadd user $dsn -samid $inputFile.USERNAME -fn $inputFile.FIRSTNAME -ln $inputFile.LASTNAME -pwd $inputFile.PASSWORD

## Deletes users from csv

#$dsn = "CN=" + $inputfile.USERNAME + ",CN=Users,DC=groupB,DC=sqrawler,DC=com"

#dsrm $dsn

