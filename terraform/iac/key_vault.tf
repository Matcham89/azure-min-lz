data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "key_vault" {
  name                        = "ramsayekeyvault"
  location                    = local.resource_location
  resource_group_name         = var.resource_group
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "linux_vm_1_secret" {
  name         = "linux_vm_1"
  value        = "Password123!"
  key_vault_id = azurerm_key_vault.key_vault.id
}
resource "azurerm_key_vault_secret" "linux_vm_2_secret" {
  name         = "linux_vm_2"
  value        = "Password123!"
  key_vault_id = azurerm_key_vault.key_vault.id
}