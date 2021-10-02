
 resource "azurerm_subnet" "backend" {
   name                   = "AZ-VM-00-web"
  resource_group_name     = var.resource_group_name
   virtual_network_name   = azurerm_virtual_network.rg.name
   address_prefixes       = ["192.168.1.0/24"]
  }
  