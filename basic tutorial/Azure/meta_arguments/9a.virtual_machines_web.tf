 resource "azurerm_windows_virtual_machine" "backend" {
  count = var.web_windows_instance_count
   name                = "${local.environment}-VM${count.index}"
   resource_group_name = var.resource_group_name
   location            = var.resource_group_location
   availability_set_id = azurerm_availability_set.backend.id
   size                = "Standard_B1ms"
   admin_username      = "pwaller"
   admin_password      = "Pa55w0rd101!"
   network_interface_ids = [element(azurerm_network_interface.backend[*].id,count.index)] ##splat [*] = for i in var : i.id 
   
 os_disk {
     caching              = "ReadWrite"
     storage_account_type = "Standard_LRS"
   }
 source_image_reference {
     publisher = "MicrosoftWindowsServer"
     offer     = "WindowsServer"
     sku       = "2016-Datacenter"
     version   = "latest"
   }
    tags = {
        environment = "${local.environment}-Terraform Demo"
    }
    depends_on = [
      azurerm_network_interface.backend
    ]
    # custom_data = filebase64("${path.module}/assets/configure_winrm_disable_firewall.ps1")
      
    }

 