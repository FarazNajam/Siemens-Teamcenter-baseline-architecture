terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "TestStorageAccountTHlDr"
    storage_account_name = "tststrgaccnthldr02"
    container_name       = "tfstate"
    key                  = "teamcenter.tfstate"
  }
}
provider "azurerm" {
  features {}
  use_oidc = true
}
