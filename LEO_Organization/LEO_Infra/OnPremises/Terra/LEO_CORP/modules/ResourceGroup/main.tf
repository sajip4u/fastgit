resource "azurerm_resource_group" "mainRG" {
  location = var.RG-Location
  name     = var.RG-Name
}