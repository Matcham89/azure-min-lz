terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state"
    storage_account_name = "ramsaytfstate"
    container_name       = "tf-state"
    key                  = "bootstrap.terraform.tfstate"
  }
}
