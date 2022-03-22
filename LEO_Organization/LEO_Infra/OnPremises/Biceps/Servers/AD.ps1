Get-WindowsFeature | where {$_.DisplayName -like "*Active*"} | ft -Wrap

Install-WindowsFeature AD-Domain-Services

# Import ADDSdeployment module for running commands for promoting

Import-Module ADDSDeployment

 #Installing the First Domain Controller in Forest

 Install-ADDSForest  -DomainName leocorproot.net -NoDnsOnNetwork -LogPath c:\Logs -SafeModeAdministratorPassword Ponnu@123456 `
 -DatabasePath C:\AD_Database -SysvolPath C:\sysvolDIR -Verbose 
 Get-ADDomain

 Get-ADDomainController
 
 Get-ADForest
 
 Get-DnsServer
<#Interfaces (LDAP, REPL, MAPI, SAM)
The first domain in the forest is called the forest root domain. The name of that domain refers to the forest, such as Nwtraders.msft. By default, information in Active Directory is shared only within the forest. In this way, the 
forest is a security boundary for the information that is contained in that instance of Active Directory.
#>
 
# Forest root and Tree root (have unique namespace) - Tree root trust and parent child trust 
#The forest root domain is, by definition, the first domain created in the forest. The Enterprise Admins and 
#Schema Admins groups are located in this domain. 

<#
Forest wide  partitions - Configurfation and schema and application directory partitions
Domain wide - Domain dir partitionm

Global Catalogs

The global catalog stores a full copy of all Active Directory objects in the directory 
for its host domain and a partial copy of all objects for all other domains in the forest. 
Users in a forest do not need to be aware of directory structure because all users see a 
single directory through the global catalog. Applications and clients can query the 
global catalog to locate any object in a forest. The global catalog is hosted on one 
or more domain controllers in the forest. It contains a partial replica of every domain 
directory partition in the forest. These partial replicas include replicas of every object 
in the forest, including the attributes most frequently used in search operations and the 
attributes required to locate a full replica of the object. A global catalog is created 
automatically on the first domain controller in the forest. 
Optionally, other domain controllers can be configured to serve as global catalogs.
A global catalog serves the following roles:

    Enables user searches for directory information about objects throughout all domains in the forest

    Resolves user principal names (UPNs) during authentication, when the authenticating domain controller does not have information about the account

    Supplies universal group membership information in a multiple domain environment

    Validates references to objects in other domains in the forest

Forest - security boundary,
Domain - Administrative boundary

#>
 Get-WindowsFeature | where {$_.DisplayName -like "*Backup*"} | ft -Wrap
 
 Install-WindowsFeature -Name Windows-Server-Backup 
  
wbadmin 
<#
$testobj = [PSCustomObject]@{
    Name = 'Value'
    Location = 'US'
}

Write-Host $testobj

#>
