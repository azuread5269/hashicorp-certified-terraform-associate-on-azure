 resource "azurerm_windows_virtual_machine" "rgauth" {
   name                = "AZ-VM-00-auth"
   resource_group_name = var.resource_group_name
   location            = var.resource_group_location
   size                = "Standard_B1ms"
   admin_username      = "pwaller"
   admin_password      = "Pa55w0rd101!"
   network_interface_ids = [
     azurerm_network_interface.rgauth.id,
   ]
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
        environment = "Terraform Demo"
    }

    depends_on = [
      azurerm_network_interface.rgauth
    ]
    # custom_data = filebase64("${path.module}/assets/configure_winrm_disable_firewall.ps1")
      
    }
