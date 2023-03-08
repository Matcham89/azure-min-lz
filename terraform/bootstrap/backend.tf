terraform {
  backend "azurerm" {
    resource_group_name  = "ramsay-cicd-rg"
    storage_account_name = "ramsaytfsa"
    container_name       = "ramsaytfstate"
    key                  = "bootstrap.terraform.tfstate"
  }
}
