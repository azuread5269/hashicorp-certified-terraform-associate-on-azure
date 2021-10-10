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
    resource_group_name = "pw5269resourcegroupvm"
    storage_account_name = "pw5269storagevm"
    container_name = "pw5269storagecontainervm"
    key = "terraform.state"
  }
}