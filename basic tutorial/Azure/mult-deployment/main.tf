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

resource "azurerm_resource_group" "pwrg" {
  name     = var.resource_group_name
  location = var.resource_group_location

}