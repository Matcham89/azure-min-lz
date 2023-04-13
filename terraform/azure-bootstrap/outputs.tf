
output "azurerm_management_group_parent" {
  value = azurerm_management_group.parent_group.name
}

output "azurerm_management_group_child" {
  value = azurerm_management_group.child_group.name
}
