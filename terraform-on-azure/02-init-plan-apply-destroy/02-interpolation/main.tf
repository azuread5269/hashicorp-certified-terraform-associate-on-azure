# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
     }
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

#create resource group
resource "azurerm_resource_group" "pwrg" {
    name     = "rg-terraexample"
    location = "West Europe"
    tags      = {
      Environment = "terraexample"
    }
}

#Create virtual network
resource "azurerm_virtual_network" "pwvnet" {
    name                = "vnet-dev-westus2-001"
    address_space       = ["10.0.0.0/16","10.1.0.0/16"]
    location            = azurerm_resource_group.pwrg.location
    resource_group_name = azurerm_resource_group.pwrg.name
}

# Create subnet
resource "azurerm_subnet" "pwsubnet" {
  name                 = "snet-dev-westus2-001"
  resource_group_name  = azurerm_resource_group.pwrg.name
  virtual_network_name = azurerm_virtual_network.pwvnet.name
  address_prefixes       = ["10.0.0.0/24"]
}