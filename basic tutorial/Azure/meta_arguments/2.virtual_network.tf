
 resource "azurerm_virtual_network" "backend" {
   name                = "${local.environment}-virtual-network"
   address_space       = ["192.168.0.0/16"]
   resource_group_name     = var.resource_group_name
   location = var.resource_group_location

    tags = {
        environment = "${local.environment}-Terraform Demo"
    }

 
 }