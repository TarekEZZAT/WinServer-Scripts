$computers = "W10DT1-CL","W10DT2-CL","W10DT3-CL"
Get-Content("C:\Users\W10dt1Admin\Desktop\computers.csv")


$Computers
Foreach($computer in $computers){
$computer
}

$a = (([adsi]"WinNT://$((Get-WMIObject Win32_ComputerSystem).Domain)").Children).Where({$_.schemaclassname -eq 'computer'})
$a 

$NICs = Get-WMIObject Win32_NetworkAdapterConfiguration -computername $computers |where{$_.IPEnabled -eq “TRUE”}
  Foreach($NIC in $NICs) {
$DNSServers = “192.168.10.2",”192.168.10.5"
 $NIC.SetDNSServerSearchOrder($DNSServers)
 $NIC.SetDynamicDNSRegistration(“TRUE”)
}
