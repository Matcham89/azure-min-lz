data "terraform_remote_state" "bootstrap" {
  backend = "azurerm"
  config = {
    resource_group_name  = "ramsay-cicd-rg"
    storage_account_name = "ramsaytfsa"
    container_name       = "ramsaytfstate"
    key                  = "bootstrap.terraform.tfstate"
  }
}

locals {
  resource_location = data.terraform_remote_state.bootstrap.outputs.resource_location
}
