resource "azurerm_availability_set" "rg" {
name                           = "AZ-VM-00-AVSET"
resource_group_name = var.resource_group_name
location  = var.resource_group_location
platform_fault_domain_count = 2
platform_update_domain_count = 2
managed = true
  
}