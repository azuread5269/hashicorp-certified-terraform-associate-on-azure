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
resource "azurerm_resource_group" "pwaller_rg112" {
  name     = "pwaller_rg112"
  location = "West Europe"
    tags      = {
      Environment = "terraexample"
    }
}

