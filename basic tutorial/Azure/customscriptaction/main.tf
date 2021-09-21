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


 resource "azurerm_virtual_network" "rg" {
   name                = "AZ-VM-00-network"
   address_space       = ["192.168.0.0/16"]
   resource_group_name     = var.resource_group_name
   location = var.resource_group_location

    tags = {
        environment = "Terraform Demo"
    }

 }
 resource "azurerm_subnet" "rg" {
   name                   = "AZ-VM-00-internal"
  resource_group_name     = var.resource_group_name
   virtual_network_name   = azurerm_virtual_network.rg.name
   address_prefixes       = ["192.168.1.0/24"]
  }
  

 resource "azurerm_network_security_group" "rg" {
  name                = "AZ-VM-00-SECGRP"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AZ-VM-00-SECRULE"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    # destination_port_ranges     = [var.destination_port_range]
    destination_port_ranges    = [80,3389,5985]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    tags = {
        environment = "Terraform Demo"
    }
  depends_on = [
    azurerm_subnet.rg,
  ]

}

 resource "azurerm_public_ip" "rg" {
    name                         = "AZ-VM-00-PUBIP"
   location                      = var.resource_group_location
   resource_group_name           = var.resource_group_name
    allocation_method            = "Dynamic"
    domain_name_label            = "pw5269dns"

        tags = {
        environment = "Terraform Demo"
    }
}

 resource "azurerm_network_interface" "rg" {
   name                = "AZ-VM-00-NIC"
   location            = var.resource_group_location
   resource_group_name = var.resource_group_name
 ip_configuration {
     name                          = "internal"
     subnet_id                     = azurerm_subnet.rg.id
     private_ip_address_allocation = "Dynamic"
    public_ip_address_id  = azurerm_public_ip.rg.id # this is a string 
    # public_ip_address_id  = ["${azurerm_public_ip.rg[count.index].id}"] # this is a list
   }

       tags = {
        environment = "Terraform Demo"
    }
 }


resource "azurerm_subnet_network_security_group_association" "rg" {
  subnet_id = azurerm_subnet.rg.id
  network_security_group_id = azurerm_network_security_group.rg.id
}


  


 resource "azurerm_windows_virtual_machine" "rg" {
   name                = "AZ-VM-00-VM01"
   resource_group_name = var.resource_group_name
   location            = var.resource_group_location
   size                = "Standard_B1ms"
   admin_username      = "pwaller"
   admin_password      = "Pa55w0rd101!"
#  delete_os_disk_on_termination = true
   network_interface_ids = [
     azurerm_network_interface.rg.id
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
    tags = {
        environment = "Terraform Demo"
    }

 }



#  resource "azurerm_virtual_machine_extension" "rg" {
#   count = 2
#   name                = "AZ-VM-00-MAEXT"
#   virtual_machine_id   = azurerm_windows_virtual_machine.rg.id
#   # publisher            = "Microsoft.Azure.Extensions"
#   publisher            = "Microsoft.Computer"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "2.1.3"
#     # type_handler_version = "1.4"

#   # CustomVMExtension Documetnation: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows

#   settings = <<SETTINGS
#     {
#         "fileUris": ["https://pw5269scriptstore.blob.core.windows.net/pw5269containerscriptstore/ansiblewinrm.ps1"]


#     }
# SETTINGS
#   protected_settings = <<PROTECTED_SETTINGS
#     {
#         "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ansiblewinrm.ps1"

#     }
#   PROTECTED_SETTINGS
#   depends_on = [azurerm_windows_virtual_machine.rg]
# }

#         # "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ansiblewinrm.ps1"
#     #   "storageAccountName": "mystorageaccountname",
#     #   "storageAccountKey": "myStorageAccountKey"



