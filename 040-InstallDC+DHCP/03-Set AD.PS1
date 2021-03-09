# 03-Set DC and AD


# Get Env Settings

##$dir = pwd | Select-Object | %{$_.ProviderPath}
$dir = 'C:\Users\Administrateur\Desktop\SCRIPTS'
. $dir"\00-EnvNetSettings.PS1"

#++++++++++++++++++++++++++++++++++++

$ActiveDirectoryParams = @{
 CreateDnsDelegation=$false;
 DatabasePath=$DatabasePath;
 #DomainMode=$DomainMode;
 DomainName=$DomainName;
 #DomainNetBiosName=$NetBiosName;
 #ForestMode=$ForestMode;
 InstallDns=$true;
 NoRebootOnCompletion=$false;
 Force=$true;
 SafeModeAdministratorPassword=(ConvertTo-SecureString $ADRestorePassword -AsPlainText -Force);
}

Install-ADDSForest @ActiveDirectoryParams