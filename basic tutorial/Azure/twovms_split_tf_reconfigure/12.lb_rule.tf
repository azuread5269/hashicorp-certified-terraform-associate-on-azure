resource "azurerm_lb_rule" "rglb" {
  resource_group_name = var.resource_group_name
  loadbalancer_id = azurerm_lb.rglb.id
  name = "AZ-VM-00-LBRULE"
  protocol = "TCP"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = "AZ-VM-00-LBVFEIP" 
  backend_address_pool_id = azurerm_lb_backend_address_pool.rglb.id
  
}
