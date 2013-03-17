## Example PowerShell script profile
##   by: Adam Charlton
## date: 14March2013
## This will output all users NOT in the "Administrators", "Domain Admins" group.
## 



### VARAIABLES
##
## Group Names to be excluded from search. 
##
$exclusionName1 = "Domain Admins"
$exclusionName2 = "Administrators"

## Group name for search.
##
$groupName = "Administrators"


### FUNCTIONS
##

## Returns an array of users.
##
function UserList {
   $userList = $(&dsquery user -samid *)|%{$_.Split("=")[1].replace(",OU","").replace(",CN","")}
   return $userList
}


## Returns an array of groups.
##
function UserGroup ($user){
   $userGroup = dsquery user -samid $user | dsget user -memberof
   return $userGroup
}


## Returns a list of users that must be excluded from output.
##
function CreateExclusionList ($u) {
   foreach ($g in UserGroup($u)) {
       if ($g -match $exclusionName1 -or $g -match $exclusionName2) {
         $exclusionList += @($u)
       }      
   }
   return $exclusionList
}


## Displays users to the screen.
##
function DisplayUsers ($list){
   if ($list -notcontains $u) {
     Write-Host $u 
   }
}


## Main users function.
##
function Users {
   foreach ($u in UserList) { 
       DisplayUsers(CreateExclusionList($u))          
   }
}


##  Main group function.
##
function Groups {
   dsquery group -samid $groupName | dsget group -members
}


### MAIN
## Comment line to display.
##

## Displays users that are members of a certain groups. 
Users

## Displays users in a particular group.
#Groups
