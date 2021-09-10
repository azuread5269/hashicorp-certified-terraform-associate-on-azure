terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.73.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  # subscription_id = "4cc7495e-1417-40c7-8d36-993c0d7027f5"


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