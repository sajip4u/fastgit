resource "azurerm_virtual_network" "VNET" {
  address_space       = var.address_space
  location            = var.location
  name                = var.name
  resource_group_name = var.ResourceGroupName
}

resource "azurerm_subnet" "subnet1" {
  name                 = "${var.name}-subnet1"
  address_prefixes     = var.subnet1_address_prefixes
  resource_group_name  = azurerm_virtual_network.VNET.resource_group_name
  virtual_network_name = azurerm_virtual_network.VNET.name
  
  depends_on = [
      azurerm_virtual_network.VNET
  ]
}

