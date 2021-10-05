resource "azurerm_network_security_rule" "backend" {
    # for_each = local.nsg_inbound_ports_map # using locals map
    for_each = var.destination_port_range_map # using variable map
    name                       = "${local.environment}-${each.value}-secrule"
    priority                   =  each.key
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range    = each.value
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.backend.name

 }
