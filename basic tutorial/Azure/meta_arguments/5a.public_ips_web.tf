 resource "azurerm_public_ip" "backend" {
  count = var.web_windows_instance_count
  name                         = "${local.environment}-PUBIP-${count.index}"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
   allocation_method            = "Dynamic"
   domain_name_label            = "pw5269dns-pubip-${count.index}"

        tags = {
            environment = "${local.environment}-Terraform Demo"
    }
}
