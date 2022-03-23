
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      #version = "2.46.0"
    }
  }
}
provider "azurerm" {
  features {

  }
}
module "ResourceGroup" {
  source      = "./modules/ResourceGroup"
  RG-Name     = "On-PremRG"
  RG-Location = "eastus2"
}

module "VNET1" {
  source                   = "./modules/VNET"
  name                     = "Onprem-VNET"
  ResourceGroupName        = module.ResourceGroup.RGNAME
  location                 = module.ResourceGroup.RGLOCATION
  address_space            = ["192.168.1.0/24"]
  subnet1_address_prefixes = ["192.168.1.0/25"]
  
  depends_on = [
    module.ResourceGroup
  ]

}
module "VNET2" {
  source                   = "./modules/VNET"
  name                     = "Cloud-VNET"
  ResourceGroupName        = module.ResourceGroup.RGNAME
  location                 = module.ResourceGroup.RGLOCATION
  address_space            = ["192.168.2.0/24"]
  subnet1_address_prefixes = ["192.168.2.0/25"]

  depends_on = [
    module.ResourceGroup
  ]
}

module "VM1" {

  source            = "./modules/VM"
  location          = module.ResourceGroup.RGLOCATION
  ResourceGroupName = module.ResourceGroup.RGNAME
  vmname            = "DC01"
  size              = "Standard_B1ms"
  subnetID          = module.VNET1.subnetID
  vm_os_publisher = "Microsoftwindowsserver"
  vm_os_offer     = "Windowsserver"
  vm_os_sku       = "2016-datacenter-smalldisk-g2"
  vm_os_version   = "latest"

  depends_on = [
    module.VNET1
  ]
}

output "publicIP" {
  value = module.VM1.publicIP
}