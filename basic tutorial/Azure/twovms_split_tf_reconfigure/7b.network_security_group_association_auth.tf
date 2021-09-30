resource "azurerm_subnet_network_security_group_association" "rgauth" {
  subnet_id = azurerm_subnet.rgauth.id
  network_security_group_id = azurerm_network_security_group.rgauth.id
}
