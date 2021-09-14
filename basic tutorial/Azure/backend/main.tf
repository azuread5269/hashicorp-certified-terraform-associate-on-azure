terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.73.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rgpw5269"
    storage_account_name = "sapw5269"
    container_name = "terraformstate"
    key = "test.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  # subscription_id = "4cc7495e-1417-40c7-8d36-993c0d7027f5"
  # --tenant TENANT_ID
  # homeTenantId": "d4cfe037-3ef4-42d7-a3f8-74f292af0782
  # tenantId": "d4cfe037-3ef4-42d7-a3f8-74f292af0782"
}

