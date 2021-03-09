#
#  Create AD DS
#

Import-Module ADDSDeployment
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-Credential (Get-Credential) `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS\DB" `
-DomainName "lab.local" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS\LOGS" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\Windows\NTDS\SYSVOL" `
-Force:$true

