# data "terraform_remote_state" "bootstrap" {
#   backend = "azurerm"
#   config = {
#     resource_group_name  = "tf-state"
#     storage_account_name = "tfstate89"
#     container_name       = "tfstate89"
#     key                  = "bootstrap.terraform.tfstate"
#   }
# }

# locals {
#   resource_location = data.terraform_remote_state.bootstrap.outputs.resource_location
# }
