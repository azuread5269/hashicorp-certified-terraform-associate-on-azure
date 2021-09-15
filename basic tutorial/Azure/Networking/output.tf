# output "resource_group_name_id" {
#     value = azurerm_resource_group.pwrg1.id
# }

output "azure_network_id" {
    value = azurerm_virtual_network.pwvn1.id
}

output "azure_subnets_id" {
#     value = ["${azurerm_subnet.pwsubs.id}"]
        value = join("", azurerm_subnet.pwsubs[*].id)
}