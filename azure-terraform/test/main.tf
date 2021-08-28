terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.74.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "pwrg" {
  name     = "example-resources"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "pwvnet" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.pwrg.name
  location            = azurerm_resource_group.pwrg.location
  address_space       = ["10.0.0.0/16"]
}