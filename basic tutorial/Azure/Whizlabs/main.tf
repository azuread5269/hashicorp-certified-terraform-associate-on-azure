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
}

variable "storage_account_name" {
    type        = string
    default = "myoldstorageacc5269"
    description = "Storage Account in Azure"
}

variable "resource_group_name" {
    type        = string
    default = "resourcegroup_40376920"
    description = "Storage Account in Azure"
}

variable "resource_group_location" {
    type        = string
    default = "East US"
    description = "Storage Account in Azure"
}


variable "account_replication_type" {
    type        = string
    default = "LRS"
    description = "Replication Account in Azure"
}

variable "account_tier" {
    type        = string
    default = "Standard"
    description = "Account Tier in Azure"
}


# resource_group_name     = "pwaller_web_RG"
# resource_group_location = "UKWest"
# storage_account_name   = "mystorage"
# account_tier            = "Standard"
# account_replication_type = "LRS"


resource "azurerm_storage_account" "pw_sa" {
  count = 2
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags = {
    environment = "Demo-SA-${count.index+1}"
  }

}


# resource "azurerm_resource_group" "pwrg" {
#   name     = var.resource_group_name
#   location = var.resource_group_location

# }