
resource "azurerm_lb_backend_address_pool" "rglb" {
  loadbalancer_id = azurerm_lb.rglb.id
  name = "AZ-VM-00-BEADDRPOOL"
  
}
