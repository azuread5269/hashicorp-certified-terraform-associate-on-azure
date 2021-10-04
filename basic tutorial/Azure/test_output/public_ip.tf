 resource "azurerm_public_ip" "backend" {
  count = var.windows_vm_count
  name                         = "${local.environment}-PUBIP-${count.index}" # multiple pub ips 
    # name                         = "${local.environment}-PUBIP" # single pub ip 
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
   allocation_method            = "Dynamic"
#    domain_name_label            = "${local.environment}-pubip" # single domain name 
   domain_name_label            = "${local.environment}-pubip${count.index}" # single domain name 

        tags = {
            environment = "${local.environment}-Terraform Demo"
    }
}
