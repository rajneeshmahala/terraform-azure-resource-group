output "resource_group_id" {
  value       = azurerm_resource_group.this.id
  description = "Resource group id"
}

output "resource_group_name" {
  description = "Name of the Resource Group Provisioned"
  value       = azurerm_resource_group.this.name
}

output "resource_group_location" {
  description = "Location of the Resource Group Provisioned"
  value       = azurerm_resource_group.this.location
}

output "resource_group_objects" {
  value       = azurerm_resource_group.this
  description = "This is the full output for the App Service Plan object."
}