<#
Create Groups and Users
 
*** THIS SCRIPT IS PROVIDED WITHOUT WARRANTY, USE AT YOUR OWN RISK ***
.DESCRIPTION
    Read Active Directory group info from groups.csv and create the groups.
    
    Example CSV File:
    
    <#
*** THIS SCRIPT IS PROVIDED WITHOUT WARRANTY, USE AT YOUR OWN RISK ***
.DESCRIPTION
    Read Active Directory group info from groups.csv and create the groups.
    
    Example CSV File:
    

    GroupName	 GroupCategory 	 GroupScope	   OU
    Finance	     Security	     Global	       OU=_Groups,DC=signalwarrant,DC=local
    R&D	         Security	     Global	       OU=_Groups,DC=signalwarrant,DC=local
    IT	         Security	     Global	       OU=_Groups,DC=signalwarrant,DC=local
    HR	         Security	     Global	       OU=_Groups,DC=signalwarrant,DC=local
    Executive	 Security	     Global	       OU=_Groups,DC=signalwarrant,DC=local


.NOTES
	File Name: 
	Author: David Hall
	Contact Info: 
		Website: www.signalwarrant.com
		Twitter: @signalwarrant
		Facebook: facebook.com/signalwarrant/
		Google +: plus.google.com/113307879414407675617
		YouTube Subscribe link: https://www.youtube.com/channel/UCgWfCzNeAPmPq_1lRQ64JtQ?sub_confirmation=1
	Requires:  
	Tested: 
.PARAMETER
    None
 

#>

$csv = Import-Csv -delimiter ";" -Path "c:\groups.csv"

ForEach ($item In $csv) 
    { 
#        $create_group = New-ADGroup -Name $item.GroupName -GroupCategory $item.GroupCategory -groupScope $item.GroupScope -Path $item.OU 
        $create_group = New-ADGroup -Name $item.GroupName -GroupCategory $item.GroupCategory -groupScope $item.GroupScope 
        Write-Host -ForegroundColor Green "Group $($item.GroupName) created!" 
    }



Import-Csv "C:\users.csv" -Delimiter ";" | ForEach-Object {
$upn = $_.SamAccountName + “@labs.local”
$uname = $_.LastName + " " + $_.FirstName

$_.Password 
$_.FirstName+";"+$_.LastName

New-ADUser -Name $uname -DisplayName $uname -GivenName $_.FirstName -Surname $_.LastName -OfficePhone $_.Phone -Department $_.Department -Title $_.JobTitle -UserPrincipalName $upn -SamAccountName $_.samAccountName -AccountPassword (ConvertTo-SecureString $_.Password -AsPlainText -force) -Enabled $true 
Add-ADGroupMember  $_.Department $_.samAccountName 
Add-ADGroupMember "Utilisateurs du Bureau à distance" $_.samAccountName
}

<#
New-ADUser -Name $uname `
-DisplayName $uname `
-GivenName $_.FirstName `
-Surname $_.LastName `
-OfficePhone $_.Phone `
-Department $_.Department `
-Title $_.JobTitle `
-UserPrincipalName $upn `
-SamAccountName $_.samAccountName `
#-Path $_.OU `
-AccountPassword (ConvertTo-SecureString $_.Password -AsPlainText -force) `
-Enabled $true ` 
# Add-ADGroupMember [-Identity] <ADGroup> [-Members] <ADPrincipal[]>
Add-ADGroupMember  $_.Department $_.samAccountName 
#>
