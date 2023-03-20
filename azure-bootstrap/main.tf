# Get the current client configuration from the AzureRM provider.
# This is used to populate the root_parent_id variable with the
# current Tenant ID used as the ID for the "Tenant Root Group"
# Management Group.

data "azurerm_client_config" "core" {}

data "azurerm_client_config" "connectivity" {
  provider = azurerm.connectivity
}
data "azurerm_client_config" "management" {
  provider = azurerm.management
}
# Declare the Azure landing zones Terraform module
# and provide a base configuration.

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "3.3.0" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  root_parent_id = var.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name
  library_path   = "${path.root}/lib"
  default_location        = "uksouth"

  deploy_management_resources = true
  subscription_id_management  = data.azurerm_client_config.management.subscription_id

  deploy_connectivity_resources = true
  subscription_id_connectivity  = data.azurerm_client_config.connectivity.subscription_id

  custom_landing_zones = {
    "${var.root_id}-lz-1" = {
      display_name               = "${upper(var.root_id)} lz-1"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = [var.lz_1]
      archetype_config = {
        archetype_id   = "default_empty"
        parameters = {}
        access_control = {}
      }
    }
    "${var.root_id}-lz-2" = {
      display_name               = "${upper(var.root_id)} lz-2"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = [var.lz_2]
      archetype_config = {
        archetype_id = "default_empty"
        parameters = {}
        access_control = {}
      }
    }
  }

}