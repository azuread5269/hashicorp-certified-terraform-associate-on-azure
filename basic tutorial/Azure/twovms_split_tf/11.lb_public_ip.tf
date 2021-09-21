 resource "azurerm_public_ip" "rglb" {
    name                         = "AZ-VM-00-LBPIP"
    location                     = var.resource_group_location
    resource_group_name          = var.resource_group_name
    allocation_method            = "Dynamic"
    domain_name_label            =  "azvm00lbpip"

    tags = {
        environment = "Terraform Demo"
    }
}
