output "dev_resource_group" {
  value = azurerm_resource_group.dev.name
}

output "test_resource_group" {
  value = azurerm_resource_group.test.name
}

output "prod_resource_group" {
  value = azurerm_resource_group.prod.name
}

output "resource_location" {
  value = var.resource_location
}