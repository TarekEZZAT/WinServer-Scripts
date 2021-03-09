# Create Groups and Users
Import-Csv "C:\users.csv" -Delimiter ";" | ForEach-Object {
$upn = $_.SamAccountName + “@woshub.com”
$uname = $_.LastName + " " + $_.FirstName

$_.Password 
$_.FirstName+";"+$_.LastName

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
}
