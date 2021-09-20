 resource "azurerm_network_security_group" "rg" {
  name                = "AZ-VM-00-SECGRP"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AZ-VM-00-SECRULE"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = "${var.destination_port_range}"
    # destination_port_ranges    = [80,3389,5985]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    tags = {
        environment = "Terraform Demo"
    }
  depends_on = [
    azurerm_subnet.rg,
  ]

}