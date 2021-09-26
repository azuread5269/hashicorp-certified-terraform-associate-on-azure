
 resource "azurerm_network_interface" "rg" {
   count = 2  
   name                = "AZ-VM-00-NIC-${count.index}"
   location            = var.resource_group_location
   resource_group_name = var.resource_group_name
 ip_configuration {
     name                          = "internal"
     subnet_id                     = azurerm_subnet.rg.id
     private_ip_address_allocation = "Dynamic"
    # public_ip_address_id  = "${azurerm_public_ip.rg[count.index].id}" # this is a string 
    # public_ip_address_id  = ["${azurerm_public_ip.rg[count.index].id}"] # this is a list
   }

       tags = {
        environment = "Terraform Demo"
    }
 }