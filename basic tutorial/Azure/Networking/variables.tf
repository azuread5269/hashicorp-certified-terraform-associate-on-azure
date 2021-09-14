variable "resource_group_name" {
    type        = string
    # default     = ["pw_rg1","pw_rg2"]
    description = "RG name in Azure"
}

variable "resource_group_location" {
    type        = string
    description = "RG location in Azure"
}


variable "azurerm_virtual_network" {
    type        = string
    description = "Azure Virtual Network"
}

variable "azurerm_subnet" {
    type        = string
    description = "Azure Virtual Network"
}

variable "subnet_prefix" {
    description = "my subnet prefixes"
    default = [
        "192.168.1.0/24",
        "192.168.2.0/24",
        "192.168.3.0/24"
    ]
}
