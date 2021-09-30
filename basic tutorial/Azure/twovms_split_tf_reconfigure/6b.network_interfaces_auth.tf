 resource "azurerm_network_interface" "rgauth" {
   name                = "AZ-VM-00-NIC-auth"
   location            = var.resource_group_location
   resource_group_name = var.resource_group_name
 ip_configuration {
     name                          = "auth"
     subnet_id                     = azurerm_subnet.rgauth.id 
     private_ip_address_allocation = "static"
     private_ip_address = "192.168.2.4"
    public_ip_address_id  = azurerm_public_ip.rgauth.id # this is a string 
    # public_ip_address_id  = ["${azurerm_public_ip.rg[count.index].id}"] # this is a list
   }

       tags = {
        environment = "Terraform Demo"
    }
 }