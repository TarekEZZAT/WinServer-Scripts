Get-WindowsFeature
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools


$DomainName = "Labs.local"
$DomainName
Install-ADDSForest -DomainName $DomainName 