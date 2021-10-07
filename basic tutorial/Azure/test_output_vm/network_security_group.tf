 resource "azurerm_network_security_group" "backend" {
  name                = "${local.environment}-secgrp"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


}