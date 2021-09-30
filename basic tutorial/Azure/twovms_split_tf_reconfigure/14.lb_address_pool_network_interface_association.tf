resource "azurerm_network_interface_backend_address_pool_association" "rglb" {
  count = 2
  # network_interface_id = azurerm_network_interface.rg[*].id
  network_interface_id  = "${azurerm_network_interface.rgweb[count.index].id}"
  ip_configuration_name = "web"
  backend_address_pool_id = azurerm_lb_backend_address_pool.rglb.id
  
}
