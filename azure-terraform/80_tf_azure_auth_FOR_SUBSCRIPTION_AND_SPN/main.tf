terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.73.0"
    }
  }
}


provider "azurerm" {
  features {}

  subscription_id = "b312c3d5-5b7c-4ab6-ae52-2b3a94b9c232" #= subscription_id
  client_id       = "68aad817-b4d7-4642-bbab-825637fdfd54" #= appid from above 
  client_secret   = "s~7bWp5MCk5xBwSdPbjaDnESZJi23jQnZi" #= password from above 
  tenant_id       = "d4cfe037-3ef4-42d7-a3f8-74f292af0782" #= tenant from above 
}

resource "azurerm_resource_group" "rg" {
  name     = "spn_terraform_rg"
  location = "westeurope"
}

resource "azurerm_storage_account" "storage" {
  name                     = "terraform0spn1storage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}