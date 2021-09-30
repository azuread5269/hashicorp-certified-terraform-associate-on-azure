 resource "azurerm_network_security_group" "rgauth" {
  name                = "AZ-VM-00-SECGRP_AUTH"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule  {
    name                       = "AZ-VM-00-SECRULE_auth"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = "${var.destination_port_range_auth}"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  } 

    tags = {
        environment = "Terraform Demo"
    }
  depends_on = [
    azurerm_subnet.rgweb
  ]

}