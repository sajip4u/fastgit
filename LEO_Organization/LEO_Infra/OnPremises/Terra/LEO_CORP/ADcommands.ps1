cd .\fastgit\LEO_Organization\LEO_Infra\OnPremises\Terra\LEO_CORP\
Get-WindowsFeature | where {$_.DisplayName -like "*Active*"} | ft -Wrap


Install-WindowsFeature AD-Domain-Services

Import-Module ADDSDeployment

$DSRMPassword = ConvertTo-SecureString "Ponnu@12345" -AsPlainText -Force

 Install-ADDSForest  -DomainName leocorproot.net  -LogPath c:\Logs -SafeModeAdministratorPassword $DSRMPassword `
 -DatabasePath C:\AD_Database -SysvolPath C:\sysvolDIR -Verbose 

 Get-ADForest
 <#
 ApplicationPartitions : {DC=DomainDnsZones,DC=leocorproot,DC=net, DC=ForestDnsZones,DC=leocorproot,DC=net}
CrossForestReferences : {}
DomainNamingMaster    : DC01.leocorproot.net
Domains               : {leocorproot.net}
ForestMode            : Windows2016Forest
GlobalCatalogs        : {DC01.leocorproot.net}
Name                  : leocorproot.net
PartitionsContainer   : CN=Partitions,CN=Configuration,DC=leocorproot,DC=net
RootDomain            : leocorproot.net
SchemaMaster          : DC01.leocorproot.net
Sites                 : {Default-First-Site-Name}
SPNSuffixes           : {}
UPNSuffixes           : {}
#>
Get-ADDomain | fl *

<#
AllowedDNSSuffixes                 : {}
ChildDomains                       : {}
ComputersContainer                 : CN=Computers,DC=leocorproot,DC=net
DeletedObjectsContainer            : CN=Deleted Objects,DC=leocorproot,DC=net
DistinguishedName                  : DC=leocorproot,DC=net
DNSRoot                            : leocorproot.net
DomainControllersContainer         : OU=Domain Controllers,DC=leocorproot,DC=net
DomainMode                         : Windows2016Domain
DomainSID                          : S-1-5-21-2898144484-2769621337-3613017253
ForeignSecurityPrincipalsContainer : CN=ForeignSecurityPrincipals,DC=leocorproot,DC=net
Forest                             : leocorproot.net
InfrastructureMaster               : DC01.leocorproot.net
LastLogonReplicationInterval       : 
LinkedGroupPolicyObjects           : {CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=leocorproot,DC=net}
LostAndFoundContainer              : CN=LostAndFound,DC=leocorproot,DC=net
ManagedBy                          : 
Name                               : leocorproot
NetBIOSName                        : LEOCORPROOT
ObjectClass                        : domainDNS
ObjectGUID                         : 7111c9e2-9059-471b-b94c-5b63cb08a05c
ParentDomain                       : 
PDCEmulator                        : DC01.leocorproot.net
PublicKeyRequiredPasswordRolling   : True
QuotasContainer                    : CN=NTDS Quotas,DC=leocorproot,DC=net
ReadOnlyReplicaDirectoryServers    : {}
ReplicaDirectoryServers            : {DC01.leocorproot.net}
RIDMaster                          : DC01.leocorproot.net
SubordinateReferences              : {DC=ForestDnsZones,DC=leocorproot,DC=net, DC=DomainDnsZones,DC=leocorproot,DC=net, 
                                     CN=Configuration,DC=leocorproot,DC=net}
SystemsContainer                   : CN=System,DC=leocorproot,DC=net
UsersContainer                     : CN=Users,DC=leocorproot,DC=net
PropertyNames                      : {AllowedDNSSuffixes, ChildDomains, ComputersContainer, DeletedObjectsContainer...}
AddedProperties                    : {}
RemovedProperties                  : {}
ModifiedProperties                 : {PublicKeyRequiredPasswordRolling}
PropertyCount                      : 30
#>

repadmin /showrepl

repadmin /replsummary 
