 resource "azurerm_public_ip" "rg" {
   count = 2
    name                         = "AZ-VM-00-PUBIP-${count.index}"
   location                      = var.resource_group_location
   resource_group_name           = var.resource_group_name
    allocation_method            = "Dynamic"
    domain_name_label            = "pw5269dns-${count.index}"

        tags = {
        environment = "Terraform Demo"
    }
}
