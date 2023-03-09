provider "azurerm" {
  features {
    use_oidc            = true
    storage_use_azuread = true
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0 "
    }
  }
}