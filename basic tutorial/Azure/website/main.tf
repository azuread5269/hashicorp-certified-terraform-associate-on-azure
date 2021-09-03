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
  count = 2
  name     = element(var.resource_group_name, count.index)
  location = var.resource_group_location
  tags = {

    environment = "Demo-RG-${count.index+1}"
  }
}

resource "azurerm_storage_account" "pw_sa" {
  count = 2
  name                     = "pwsa5269${count.index+1}"
  resource_group_name      = element(var.resource_group_name, count.index)
  location                 = var.resource_group_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags = {
    environment = "Demo-SA-${count.index+1}"
  }
  depends_on = [
    azurerm_resource_group.pw_rg,
  ]
}

resource "azurerm_storage_container" "pw_sc" {
  count = 2
  name                  = "pwsc5269${count.index+1}"
  # storage_account_name  = element(var.storage_account_name, count.index)
  storage_account_name = "pwsa5269${count.index+1}"
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.pw_sa,
  ]
}

resource "azurerm_storage_blob" "pw_sb" {
  count = 2
  name                   = "pwsb5269${count.index+1}"
  storage_account_name   = "pwsa5269${count.index+1}"
  storage_container_name = "pwsc5269${count.index+1}"
  type                   = "Block"
  # source                 = "some-local-file.zip"
  depends_on = [
    azurerm_storage_container.pw_sc,
  ]

}