resource "azurerm_network_interface" "backend" {
  count = var.web_windows_instance_count
  name = "${local.environment}-network_interface${count.index}"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
      name = "web_windows_ip-${count.index}"
      subnet_id = azurerm_subnet.backend.id 
      private_ip_address_allocation = "static"
      private_ip_address = "192.168.1.${count.index+4}"
    #   public_ip_address_id  = "${azurerm_public_ip.backend.${count.index}.id}" # this is a string 
      # public_ip_address_id = "azurerm_public_ip.backend${count.index}"
      public_ip_address_id  = "${azurerm_public_ip.backend[count.index].id}" # this is a string 
      
      

  }
}