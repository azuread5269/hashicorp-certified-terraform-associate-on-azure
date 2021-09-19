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

 resource "azurerm_resource_group" "rg" {
   name     = "TFRDemo"
   location = "ukwest"
 }
 resource "azurerm_virtual_network" "rg" {
   name                = "rg-network"
   address_space       = ["10.0.0.0/16"]
   location            = azurerm_resource_group.rg.location
   resource_group_name = azurerm_resource_group.rg.name
 }
 resource "azurerm_subnet" "rg" {
   name                 = "internal"
   resource_group_name  = azurerm_resource_group.rg.name
   virtual_network_name = azurerm_virtual_network.rg.name
   address_prefixes     = ["10.0.2.0/24"]
 }

 resource "azurerm_public_ip" "rg" {
   count = 2
    name                         = "pubip-${count.index}"
   location                     = azurerm_resource_group.rg.location
   resource_group_name = azurerm_resource_group.rg.name
    allocation_method            = "Dynamic"
    domain_name_label            = "pw5269-${count.index}"
}

 resource "azurerm_network_interface" "rg" {
   count = 2  
   name                = "AZ-VM-00-NIC-${count.index}"
   location            = azurerm_resource_group.rg.location
   resource_group_name = azurerm_resource_group.rg.name
 ip_configuration {
     name                          = "internal"
     subnet_id                     = azurerm_subnet.rg.id
     private_ip_address_allocation = "Dynamic"
    public_ip_address_id  = "${azurerm_public_ip.rg[count.index].id}" # this is a string 
    # public_ip_address_id  = ["${azurerm_public_ip.rg[count.index].id}"] # this is a list


      

   }
 }



 resource "azurerm_windows_virtual_machine" "rg" {
   count = 2  
   name                = "AZ-VM-00-${count.index}"
   resource_group_name = azurerm_resource_group.rg.name
   location            = azurerm_resource_group.rg.location
   size                = "Standard_B1s"
   admin_username      = "pwaller"
   admin_password      = "Pa55w0rd101!"
   network_interface_ids = [
     azurerm_network_interface.rg.*.id[count.index],
   ]
 os_disk {
     caching              = "ReadWrite"
     storage_account_type = "Standard_LRS"
   }
 source_image_reference {
     publisher = "MicrosoftWindowsServer"
     offer     = "WindowsServer"
     sku       = "2016-Datacenter"
     version   = "latest"
   }
 }