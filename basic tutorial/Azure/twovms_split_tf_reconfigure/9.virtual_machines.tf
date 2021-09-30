 resource "azurerm_windows_virtual_machine" "rgweb" {
   count = 2  
   name                = "AZ-VM-00-${count.index}"
   resource_group_name = var.resource_group_name
   location            = var.resource_group_location
   availability_set_id = azurerm_availability_set.rgweb.id
   size                = "Standard_B1ms"
   admin_username      = "pwaller"
   admin_password      = "Pa55w0rd101!"
   network_interface_ids = [
     azurerm_network_interface.rgweb.*.id[count.index],
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

    # custom_data = filebase64("${path.module}/assets/configure_winrm_disable_firewall.ps1")
      
    }

 