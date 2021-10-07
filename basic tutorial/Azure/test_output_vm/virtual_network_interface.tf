resource "azurerm_network_interface" "backend" {
  count = var.windows_vm_count
  name = "${local.environment}-network_interface${count.index}" # multiple VMS
  # name = "${local.environment}-network_interface" # single VM
  location = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
      # name = "web_windows_ip-${count.index}"
      name = "${local.environment}-web_windows_ip"
      subnet_id = azurerm_subnet.backend.id 
      private_ip_address_allocation = "static"
      private_ip_address = "192.168.1.${count.index+4}" # multiple ips - start at 4 so as not be part of azure infra
      # private_ip_address = "192.168.1.4" # single ip 
      # public_ip_address_id  = azurerm_public_ip.backend.id # single public ip  this is a string 
      public_ip_address_id = "${azurerm_public_ip.backend[count.index].id}" # multple pub ips 

  }
}