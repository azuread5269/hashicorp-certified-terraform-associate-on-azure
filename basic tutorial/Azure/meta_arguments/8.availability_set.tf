resource "azurerm_availability_set" "backend" {
name                           = "${local.environment}-AVSET"
resource_group_name = var.resource_group_name
location  = var.resource_group_location
platform_fault_domain_count = 2
platform_update_domain_count = 2
managed = true

    tags = {
        environment = "${local.environment}-Terraform Demo"
    }
  
}