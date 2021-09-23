resource "azurerm_network_interface_backend_address_pool_association" "rglb" {
  count = 2
  # network_interface_id = azurerm_network_interface.rg[*].id
  network_interface_id  = "${azurerm_network_interface.rg[count.index].id}"
  ip_configuration_name = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.rglb.id
  
}
