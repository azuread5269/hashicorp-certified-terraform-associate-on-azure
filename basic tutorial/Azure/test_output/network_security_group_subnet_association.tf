
resource "azurerm_subnet_network_security_group_association" "backend" {
  subnet_id = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.backend.id
}
