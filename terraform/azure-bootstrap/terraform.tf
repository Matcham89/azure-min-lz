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
  features {}
}

provider "azurerm" {
  alias           = "connectivity"
  features {}
}

provider "azurerm" {
  alias           = "management"
  features {}
}
