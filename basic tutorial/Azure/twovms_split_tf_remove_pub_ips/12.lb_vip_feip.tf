
resource "azurerm_lb" "rglb" {
  name                = "AZ-VM-00-LBVIP"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  
  frontend_ip_configuration {
    name                 = "AZ-VM-00-LBVFEIP"
    public_ip_address_id = azurerm_public_ip.rglb.id
    # subnet_id = azurerm_subnet.rg.id

  }
}
