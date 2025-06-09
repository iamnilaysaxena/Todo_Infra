terraform {
  backend "azurerm" {
    resource_group_name  = "rg-rudra"
    storage_account_name = "todoappaccount"
    container_name       = "tf-state-file"
    key                  = "development/development.tfstate"
  }
}
