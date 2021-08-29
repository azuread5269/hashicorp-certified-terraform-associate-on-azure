# valid for terraform version 0.13
# provider "azurerm" {
#   version = "=2.40.0"
#   features {}
# }

# valid for terraform version 0.14


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "myFirstResourceGroup"
  location = "westeurope"
}