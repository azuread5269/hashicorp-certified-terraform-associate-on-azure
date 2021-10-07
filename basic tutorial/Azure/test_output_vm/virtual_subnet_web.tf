
 resource "azurerm_subnet" "backend" {
   name                   = "${local.environment}-web-subnet"
   resource_group_name     = var.resource_group_name
   virtual_network_name   = azurerm_virtual_network.backend.name
   address_prefixes       = ["192.168.1.0/24"]
  }
  