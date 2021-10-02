
 resource "azurerm_virtual_network" "backend" {
   name                = "AZ-VM-00-network"
   address_space       = ["192.168.0.0/16"]
   resource_group_name     = var.resource_group_name
   location = var.resource_group_location

    tags = {
        environment = "Terraform Demo"
    }

 
 }