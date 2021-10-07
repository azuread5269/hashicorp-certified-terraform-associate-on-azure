terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.73.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">=3.0"
          
    }
  }
  backend "azurerm" {
    resource_group_name = "pw5269resourcegroup"
    storage_account_name = "pw5269storage"
    container_name = "pw5269storagecontainer"
    key = "terraform.state"
  }
}