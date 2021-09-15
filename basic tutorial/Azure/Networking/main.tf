terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.73.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "pwrg1"
    storage_account_name = "pwa5269storage"
    container_name = "pwstorageconainer5269"
    key = "terraform.state"
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

# resource "azurerm_resource_group" "pwrg1" {
#   name = var.resource_group_name
#   location = var.resource_group_location 
# }

resource "azurerm_virtual_network" "pwvn1" {
  name                = var.azurerm_virtual_network
  location            = var.resource_group_location 
  resource_group_name = var.resource_group_name
  address_space       = ["192.168.0.0/16"]
}


resource "azurerm_subnet" "pwsubs" {
  count = "${length(var.subnet_prefix)}"
  name   = "pwsubnet${count.index+1}"
  # name = var.azurerm_subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.azurerm_virtual_network
  # address_prefixes     = ["10.0.1.0/24"]
   address_prefixes = [var.subnet_prefix[count.index]] # if a list 
  #  address_prefixes = "${element(var.subnet_prefix, count.index)}" # if a list 
  depends_on = [
    azurerm_virtual_network.pwvn1,
  ]
}