output "private_ip" {
  value = azurerm_network_interface.backend[*].private_ip_address
# value = [for i in azurerm_network_interface.backend.private_ip_address[count.index]: i ]
# value = [for i in windows_vm_count : i.azurerm_network_interface.backend.private_ip_address ]
}

output "public_ip" {
    value = azurerm_public_ip.backend[*].ip_address
#     value = [for i in azurerm_public_ip.backend.ip_address: i ]
}

output "public_domain_name_label" {
    value = azurerm_public_ip.backend[*].domain_name_label
# value = [for i in azurerm_public_ip.backend.domain_name_label : i ]
}
output "public_fqdn" {
    value = azurerm_public_ip.backend[*].fqdn
#     value = [for i in azurerm_public_ip.backend.fqdn : i ]
}


