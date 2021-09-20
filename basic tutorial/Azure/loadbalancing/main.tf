terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.73.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">=3.0"
          
    }
  }
  # backend "azurerm" {
  #   resource_group_name = "pw5269resourcegroup"
  #   storage_account_name = "pw5269storage"
  #   container_name = "pw5269storagecontainer"
  #   key = "terraform1.state"
  # }
}


provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "b312c3d5-5b7c-4ab6-ae52-2b3a94b9c232" #= subscription_id
  client_id       = "a9d85e3e-105d-4375-894e-1086362f02c9" # = appid from above 
  client_secret   = "w2E7Q~1NUKFekO88RKHR64v_uo7Oi46NJdyiK" #= password from above 
  tenant_id       = "d4cfe037-3ef4-42d7-a3f8-74f292af0782" #= tenant from above 
}



resource "azurerm_public_ip" "rg" {
    name                         = "AZ-VM-00-LBPIP"
    location                     = var.resource_group_location
    resource_group_name          = var.resource_group_name
    allocation_method            = "Dynamic"
    domain_name_label            =  "azvm00lbpip"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_lb" "rg" {
  name                = "AZ-VM-00-LBVIP"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  
  

  frontend_ip_configuration {
    name                 = "AZ-VM-00-LBVFEIP"
    public_ip_address_id = azurerm_public_ip.rg.id
    subnet_id = "AZ-VM-00-internal"

  }



}

resource "azurerm_lb_rule" "rg" {
  resource_group_name = var.resource_group_name
  loadbalancer_id = azurerm_lb.rg.id
  name = "AZ-VM-00-LBRULE"
  protocol = "TCP"
  frontend_port = 3389
  backend_port = 3389
  frontend_ip_configuration_name = "AZ-VM-00-LBVFEIP" 
  
}

resource "azurerm_lb_backend_address_pool" "rg" {
  loadbalancer_id = azurerm_lb.rg.id
  name = "AZ-VM-00-BEADDRPOOL"
}