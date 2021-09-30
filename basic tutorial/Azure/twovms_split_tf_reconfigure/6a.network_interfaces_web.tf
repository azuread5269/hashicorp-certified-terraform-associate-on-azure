
 resource "azurerm_network_interface" "rgweb" {
   count = 2  
   name                = "AZ-VM-00-NIC-${count.index}"
   location            = var.resource_group_location
   resource_group_name = var.resource_group_name
 ip_configuration {
     name                          = "web"
     subnet_id                     = azurerm_subnet.rgweb.id 
     private_ip_address_allocation = "static"
     private_ip_address = "192.168.1.${count.index+4}"
    public_ip_address_id  = "${azurerm_public_ip.rgweb[count.index].id}" # this is a string 
    # public_ip_address_id  = ["${azurerm_public_ip.rg[count.index].id}"] # this is a list
   }

       tags = {
        environment = "Terraform Demo"
    }
 }