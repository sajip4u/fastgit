output "RGNAME" {
  description = "Name of RG"
  value       = azurerm_resource_group.mainRG.name
}

output "RGLOCATION" {
  description = "Location of RG"
  value       = azurerm_resource_group.mainRG.location
}