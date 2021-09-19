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

resource "azurerm_resource_group" "pwrg1" {
  name = var.resource_group_name
  location = var.resource_group_location 
}

resource "azurerm_virtual_network" "pw5269vn1" {
  name                = var.azurerm_virtual_network
  location            = var.resource_group_location 
  resource_group_name = var.resource_group_name
  address_space       = ["192.168.0.0/16"]
      tags = {
        environment = "Terraform Demo"
    }
}


resource "azurerm_subnet" "pw5269subs" {
  count = "${length(var.subnet_prefix)}"
  name   = "pwsubnet${count.index+1}"
  # name = var.azurerm_subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.azurerm_virtual_network
  # address_prefixes     = ["10.0.1.0/24"]
   address_prefixes = [var.subnet_prefix[count.index]] # if a list 
  #  address_prefixes = "${element(var.subnet_prefix, count.index)}" # if a list 
  depends_on = [
    azurerm_virtual_network.pw5269vn1,
  ]
}


resource "azurerm_network_security_group" "pw5269nsg1" {
  name                = var.azurerm_network_security_group
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = var.security_rule_name
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
    azurerm_subnet.pw5269subs,
  ]

}

# Create public IPs
resource "azurerm_public_ip" "pw5269pubip1" {
    name                         = var.public_ip_address
    location                     = var.resource_group_location
    resource_group_name          = var.resource_group_name
    allocation_method            = "Dynamic"
    domain_name_label            = "pw5269vm1"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_public_ip" "pw5269pubip2" {
    name                         = var.public_ip_address
    location                     = var.resource_group_location
    resource_group_name          = var.resource_group_name
    allocation_method            = "Dynamic"
    domain_name_label            = "pw5269vm2"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_interface" "pw5269nic1" {
  name                = var.network_interface_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "lan"
    subnet_id                     = azurerm_subnet.pw5269subs[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pw5269pubip1.id
  }

  depends_on = [
    azurerm_subnet.pw5269subs,
  ]

      tags = {
        environment = "Terraform Demo"
    }

}

resource "azurerm_network_interface" "pw5269nic2" {
  name                = var.network_interface_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "lan"
    subnet_id                     = azurerm_subnet.pw5269subs[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pw5269pubip2.id
  }

  depends_on = [
    azurerm_subnet.pw5269subs,
  ]

      tags = {
        environment = "Terraform Demo"
    }

}

# # Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "pw5269nictonsg1" {
#     network_interface_id      = azurerm_network_interface.pw5269nic1.id
#     network_security_group_id = azurerm_network_security_group.pw5269nsg1.id
# }

# ## need to apply nsg to subnet !!!!

# # Connect the security group to the network interface
# resource "azurerm_network_interface_security_group_association" "pw5269nictonsg2" {
#     network_interface_id      = azurerm_network_interface.pw5269nic2.id
#     network_security_group_id = azurerm_network_security_group.pw5269nsg2.id
# }

resource "azurerm_subnet_network_security_group_association" "pw5269nictonsgs" {
  subnet_id =   azurerm_subnet.pw5269subs[0].id
  network_security_group_id = azurerm_network_security_group.pw5269nsg1.id
}




resource "azurerm_virtual_machine" "pw5269vm1" {
  name                  = "${var.vm_name_prefix}-vm"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.pw5269nic1.id]
  vm_size               = "Standard_B1s"
  delete_data_disks_on_termination = true

storage_image_reference {
  publisher = "microsoftwindowsserver"
  offer     = "windowsserver"
  sku       = "2019-Datacenter"
  version   = "latest"
  }

storage_os_disk {
  name              = "pw5269disk1"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "Standard_LRS"
  
  }
os_profile {
  computer_name  = "pw52692019DC1"
  admin_username = "pwaller"
  admin_password = "Pa55w0rd101!"
  }

  os_profile_windows_config {
  provision_vm_agent = true
  
     winrm {
         protocol = "http"
        }
    
  }


}


resource "azurerm_virtual_machine" "pw5269vm2" {
  name                  = "${var.vm_name_prefix}-vm"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.pw5269nic2.id]
  vm_size               = "Standard_B1s"
  delete_data_disks_on_termination = true

storage_image_reference {
  publisher = "microsoftwindowsserver"
  offer     = "windowsserver"
  sku       = "2019-Datacenter"
  version   = "latest"
  }

storage_os_disk {
  name              = "pw5269disk2"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "Standard_LRS"
  
  }
os_profile {
  computer_name  = "pw52692019DC2"
  admin_username = "pwaller"
  admin_password = "Pa55w0rd101!"
  }

  os_profile_windows_config {
  provision_vm_agent = true
  
     winrm {
         protocol = "http"
        }
    
  }

}