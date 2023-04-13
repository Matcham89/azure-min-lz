#
# current subscription id
#

data "azurerm_subscription" "current" {
}

#
# management group
#

resource "azurerm_management_group" "parent_group" {
  display_name = "ManagementGroup"

  subscription_ids = [
    data.azurerm_subscription.current.subscription_id,
  ]
}

resource "azurerm_management_group" "child_group" {
  display_name               = "ChildGroup"
  parent_management_group_id = azurerm_management_group.parent_group.id

  subscription_ids = [
    data.azurerm_subscription.current.subscription_id,
  ]
  # other subscription IDs can go here
  depends_on = [
    azurerm_management_group.parent_group
  ]
}


#
# resource group policy - uksouth only deployment
#

resource "azurerm_policy_definition" "region_policy" {
  name                = "only-deploy-in-uksouth"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "uksouth-policy-definition"
  management_group_id = azurerm_management_group.parent_group.id

  policy_rule = <<POLICY_RULE
 {
    "if": {
      "not": {
        "field": "location",
        "equals": "uksouth"
      }
    },
    "then": {
      "effect": "Deny"
    }
  }
POLICY_RULE
}

resource "azurerm_management_group_policy_assignment" "mg_policy_assignment" {
  name                 = "management-group-policy"
  policy_definition_id = azurerm_policy_definition.region_policy.id
  management_group_id  = azurerm_management_group.parent_group.id
}



#
# resource groups dev/test/prod
#

resource "azurerm_resource_group" "dev_resource_group" {
  name     = var.dev_resource_group_name
  location = var.dev_resource_location
}
