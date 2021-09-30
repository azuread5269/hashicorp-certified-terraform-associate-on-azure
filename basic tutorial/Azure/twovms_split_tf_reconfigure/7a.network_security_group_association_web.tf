resource "azurerm_subnet_network_security_group_association" "rgweb" {
  subnet_id = azurerm_subnet.rgweb.id
  network_security_group_id = azurerm_network_security_group.rgweb.id
}
