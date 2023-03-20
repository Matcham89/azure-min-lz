# Configure Terraform to set the required AzureRM provider
# version and features{} block.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.19.0"
      configuration_aliases = [
        azurerm.connectivity,
        azurerm.management,
      ]
    }
  }
}

provider "azurerm" {
  alias           = "connectivity"
  subscription_id = ""
  features {}
}

provider "azurerm" {
  alias           = "management"
  subscription_id = ""
  features {}
}


provider "azurerm" {
  features {}
}