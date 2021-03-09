# DFS Installation 
# On Server
Get-WindowsFeature FS-DFS*
Install-WindowsFeature FS-DFS-NameSpace -IncludeManagementTools
Install-WindowsFeature FS-DFS-Replication -IncludeManagementTools
Get-WindowsFeature FS-DFS*

# On Client
Invoke-Command -ComputerName WSRV2-BK -command {Get-WindowsFeature FS-DFS*}
#Invoke-Command -ComputerName <SRV2>,<SRV3> -command {Install-WindowsFeature FS-DFS-Replication}
Invoke-Command -ComputerName WSRV2-BK -command {Install-WindowsFeature FS-DFS-Replication -IncludeManagementTools}
Invoke-Command -ComputerName WSRV2-BK -command {Get-WindowsFeature FS-DFS*}




