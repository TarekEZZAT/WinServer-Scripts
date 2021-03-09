# NIC Teaming

# Commandes en rapport avec le NIC teaming sous Windows Server.

Get-Command -Module NetLbfo

<#
Notre serveur CORE01 dispose de deux cartes réseaux, 
une nommée « LAN »
l’autre dispose de son nom d’origine « Ethernet1 ».

Nous allons associer ces deux cartes réseau au sein d’un NIC teaming.

On va renommer les cartes réseau. 
LAN deviendra LAN1,
Ethernet1 deviendra LAN2. 

On vérifie que les changements sont pris en compte en listant les cartes réseau.
#>

Get-NetAdapter -Name LAN | Rename-NetAdapter -NewName LAN1
Get-NetAdapter -Name Ethernet1 | Rename-NetAdapter -NewName LAN2
Get-NetAdapter | fl Name

New-NetLbfoTeam -Name "LAN-Teaming" -TeamMembers LAN1,LAN2 -TeamingMode 
SwitchIndependent -LoadBalancingAlgorithm IPAddresses

#+++++++++++++++++++++++++++++++++++++++++
<# Editer et supprimer un NIC Teaming existant

Si vous avez besoin de changer la configuration d’une association de cartes réseau existante, inutile de tout recréer de zéro. Utilisez simplement le commandlet « Set-NetLbfoTeam », et éditez le paramètre que vous voulez.
#>

#Exemple pour passer le mode d’équipe sur « LACP » :
Set-NetLbfoTeam -Name LAN-Teaming -TeamingMode LACP

#Supprimer un NIC Teaming

Remove-NetLbfoTeam -Name LAN-Teaming
