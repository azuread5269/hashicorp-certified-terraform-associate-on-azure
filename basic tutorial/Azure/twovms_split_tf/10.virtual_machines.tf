locals {
vm_custom_data = <<CUSTOM_DATA
$GI = Get-Item WSMan:\localhost\Service\AllowUnencrypted
IF (!($GI.Value -match 'true'))
{
    Write-Warning "AllowUnencrypted not already configured, so configuring" -Verbose
    Set-Item WSMan:\localhost\Service\AllowUnencrypted -value true
    Set-Item WSMan:\localhost\Service\Auth\Basic -Value true 
}
ELSE
{
    Write-Verbose "AllowUnencrypted already configured" -Verbose
}
Write-Verbose "Disable all firewall rules" -Verbose
Get-NetFirewallProfile | % {Set-NetFirewallProfile -Name $_.name -Enabled False}

new-item c:\myfile.txt 
add-content c:\myfile.txt ${var.resource_group_name}

CUSTOM_DATA

}
 
 
 resource "azurerm_windows_virtual_machine" "rg" {
   count = 2  
   name                = "AZ-VM-00-${count.index}"
   resource_group_name = var.resource_group_name
   location            = var.resource_group_location
   availability_set_id = azurerm_availability_set.rg.id
   size                = "Standard_B1ms"
   admin_username      = "pwaller"
   admin_password      = "Pa55w0rd101!"
   network_interface_ids = [
     azurerm_network_interface.rg.*.id[count.index],
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

 