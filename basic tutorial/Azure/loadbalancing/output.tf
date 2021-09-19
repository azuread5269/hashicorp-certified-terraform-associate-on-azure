# # output "resource_group_name_id" {
# #     value = azurerm_resource_group.pwrg1.id
# # }

# output "azure_network_id" {
#     value = azurerm_virtual_network.pw5269vn.id
# }

# output "azure_subnets_id" {
# #     value = ["${azurerm_subnet.pwsubs.id}"]
#         value = join("", azurerm_subnet.pw5269subs[*].id)
# }
# output "azure_pubip_id1" {
# #     value = ["${azurerm_subnet.pwsubs.id}"]
#         value = azurerm_public_ip.pw5269pubip1.id
# }

# output  "azurerm_network_interface1" {
#         value = azurerm_network_interface.pw5269nic1.private_ip_address
# }

# output "azurerm_public_ip1" {
#         value = azurerm_public_ip.pw5269pubip1.ip_address
# }


# output "azure_pubip_id2" {
# #     value = ["${azurerm_subnet.pwsubs.id}"]
#         value = azurerm_public_ip.pw5269pubip2.id
# }

# output  "azurerm_network_interface2" {
#         value = azurerm_network_interface.pw5269nic2.private_ip_address
# }

# output "azurerm_public_ip2" {
#         value = azurerm_public_ip.pw5269pubip2.ip_address
# }
