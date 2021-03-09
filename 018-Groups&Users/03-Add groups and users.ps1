# Add groups and users

# Step 1: Import the AD Module
Import-Module ActiveDirectory

#Step 2: Add the User to the Group
Add-ADGroupMember -Identity "GroupNAME" -Members <USERNAME>

#Step 3: Confirm the User Was Added
C:\>Get-ADGroupMember "<GroupNAME>"


#++++++++++++++++++++++++

$csv = Import-Csv -Path "c:\scripts\members.csv"
#Groupname and Membername would be the header of your CSV file

ForEach ($item In $csv)
{
$Add_group = Add-ADGroupMember -Identity $item.GroupName -Members $item.Membername
Write-Host -ForegroundColor Green "Group $($item.GroupName) modified!"
}








