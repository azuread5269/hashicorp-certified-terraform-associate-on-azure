
 resource "azurerm_subnet" "rgauth" {
   name                   = "AZ-VM-00-auth"
  resource_group_name     = var.resource_group_name
   virtual_network_name   = azurerm_virtual_network.rg.name
   address_prefixes       = ["192.168.2.0/24"]
  }
  