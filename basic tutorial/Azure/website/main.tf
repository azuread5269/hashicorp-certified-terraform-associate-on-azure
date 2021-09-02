terraform {
    required_version = ">=1.0.5"
    required_providers {
      azurerm = {
      source = "hashicorp/azurerm"
      version = "2.73.0"
    }
  }
}

provider "azurerm" {
  features {}

 #make sure the SPN has ben set!
  # subscription_id = "b312c3d5-5b7c-4ab6-ae52-2b3a94b9c232" #= subscription_id
  # client_id       = "68aad817-b4d7-4642-bbab-825637fdfd54" #= appid from above 
  # client_secret   = "s~7bWp5MCk5xBwSdPbjaDnESZJi23jQnZi" #= password from above 
  # tenant_id       = "d4cfe037-3ef4-42d7-a3f8-74f292af0782" #= tenant from above 
}

resource "azurerm_resource_group" "pw_rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "pw_sa" {
  name                     = "pwsa5269"
  resource_group_name      = azurerm_resource_group.pw_rg.name
  location                 = azurerm_resource_group.pw_rg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "pw_sc" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.pw_sa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "pw_sb" {
  name                   = "my-awesome-content.zip5269"
  storage_account_name   = azurerm_storage_account.pw_sa.name
  storage_container_name = azurerm_storage_container.pw_sc.name
  type                   = "Block"
  # source                 = "some-local-file.zip"
}