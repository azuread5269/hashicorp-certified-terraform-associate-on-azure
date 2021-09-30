 resource "azurerm_public_ip" "rgauth" {
   name                         = "AZ-VM-00-PUBIP-auth"
   location                      = var.resource_group_location
   resource_group_name           = var.resource_group_name
    allocation_method            = "Dynamic"
    domain_name_label            = "pw5269dns-auth"

        tags = {
        environment = "Terraform Demo"
    }
}
