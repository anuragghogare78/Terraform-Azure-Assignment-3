terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfprodbackend2026anurag"
    container_name      = "tfstate"
    key                 = "prod.tfstate"
  }
}

provider "azurerm" {
  features {}
}