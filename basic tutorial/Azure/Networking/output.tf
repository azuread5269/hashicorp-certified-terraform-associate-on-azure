# output "resource_group_name_id" {
#     value = azurerm_resource_group.pwrg1.id
# }

output "azure_network_id" {
    value = azurerm_virtual_network.pw5269vn1.id
}

output "azure_subnets_id" {
#     value = ["${azurerm_subnet.pwsubs.id}"]
        value = join("", azurerm_subnet.pw5269subs[*].id)
}
output "azure_pubip_id" {
#     value = ["${azurerm_subnet.pwsubs.id}"]
        value = azurerm_public_ip.pw5269pubip1.id
}

output  "azurerm_network_interface" {
        value = azurerm_network_interface.pw5269nic1.private_ip_address
}

output "azurerm_public_ip" {
        value = azurerm_public_ip.pw5269pubip1.ip_address
}

