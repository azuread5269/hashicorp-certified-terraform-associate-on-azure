# output "resource_group_name_id" {
#     value = azurerm_resource_group.pwrg1.id
# }

output "azure_network_id" {
    value = azurerm_virtual_network.rg.id
}

output "azure_subnets_id" {
       value = join("", azurerm_subnet.rg[*].id)
}
output "azure_pubip_id" {
       value =  join("" ,  azurerm_public_ip.rg[*].id)
}



