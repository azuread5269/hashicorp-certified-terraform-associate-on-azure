
resource "azurerm_subnet_network_security_group_association" "rg" {
  subnet_id = azurerm_subnet.rg.id
  network_security_group_id = azurerm_network_security_group.rg.id
}
