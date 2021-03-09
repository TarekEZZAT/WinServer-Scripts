## iSCSI Initiators (pre-target) ##

# start iscsi initiator service on both nodes
Invoke-Command CL1-NUG,CL2-NUG { Get-Service #iscsi# Set-Service -StartupType Automatic -Pasehru Start-ServiCe

# view iscsi initiator addresses
Invoke-Command CL1-NUG,CL2-NUG { Get-InitiatorPort }

# create target portal for discovery
Invoke-Command CL1-NUG.CL2-NUG { New-IscsiTargetPortal -TargetPortalAddress 192.168.3.105 } 

## iSCSI Target 

# create iscsi lun
Invoke-Command FS-NUG { New-IscsiVirtualblisk -Path D:\CL-DataDisk.vhdx -SizeBytes 100GB }
Invoke-Command F5-NVG { Net-IscsiVirtualDisk -Path D:\CL-QuorumDisk.vhdx -SizeBytes 1GB }

# create iscsi target
Invoke-Command FS-NUG { New-IscsiServerTarget -TargetName CL-Target -Initiatorlds "IQN:ion.1991-05.com.microsoft:c11-nug.nuggetlab.com","IQN:ign.1991-05.com.nicrosoft"}

# assign luns to target
Invoke-Command FS-NUG { Add-IscsiVirtualCisktargetvapping -TargetName CL-Target -Path D:\CL-DataDisk.vhdk }
Invoke-Connand FS-NUG { Add-IscsiVirtualDiskTargetMapping -TargetName CL-Target -Path D:\CL-goorumnisk.vhdx }

## iSCSI Initiators (post-target) ##

#update discovery portal with new target information
Invoke-Command CL1-NUG.CL2-NUG ( Get-IscsiTargetPortal	Update-IscsiTargetPortal )

# view iscsi target
Invoke-Command CL1-NUG.CL2-NUG { Get-IscsiTarget }

# connect initlators to target
Invoke-Command C11-NUG,CL2-NUG { Get-IscsiTarget | Connect-IsciTarget}

# force the connection to persist (across reboots)
Invoke-Command CLI-NUG.CL2-NUG { Get-IscsSesslon Register-IscsiSessIon }
