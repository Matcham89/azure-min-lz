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
}


#
# resource groups dev/test/prod
#

resource "azurerm_resource_group" "dev" {
  name     = "ramsay-dev"
  location = var.resource_location
}

resource "azurerm_resource_group" "test" {
  name     = "ramsay-test"
  location = var.resource_location
}

resource "azurerm_resource_group" "prod" {
  name     = "ramsay-prod"
  location = var.resource_location
}

resource "azurerm_management_group" "example" {
  display_name = "Some Management Group"
}

#
# resource group policy - uksouth only deployment
#

resource "azurerm_policy_definition" "mg_policy" {
  name                = "only-deploy-in-uksouth"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "my-policy-definition"
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
  policy_definition_id = azurerm_policy_definition.mg_policy.id
  management_group_id  = azurerm_management_group.parent_group.id
}

#
# subscription policy - uksouth only deployment
#

resource "azurerm_policy_definition" "sb_policy_definition" {
  name         = "only-deploy-in-uksouth"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed resource types"

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

resource "azurerm_subscription_policy_assignment" "policy_assignment" {
  name                 = "policy assignment"
  policy_definition_id = azurerm_policy_definition.sb_policy_definition.id
  subscription_id      = data.azurerm_subscription.current.id
}