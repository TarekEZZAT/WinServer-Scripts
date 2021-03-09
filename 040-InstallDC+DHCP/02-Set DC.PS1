# 03-Set DC and AD


# Get Env Settings

##$dir = pwd | Select-Object | %{$_.ProviderPath}
$dir = 'C:\Users\Administrateur\Desktop\SCRIPTS'
. $dir"\00-EnvNetSettings.PS1"

#++++++++++++++++++++++++++++++++++++


#Import-Module ADDSDeployment
Install-WindowsFeature 'AD-Domain-Services' `
	-IncludeAllSubFeature `
	-IncludeManagementTools

