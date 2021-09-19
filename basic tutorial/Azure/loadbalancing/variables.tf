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

variable "azurerm_network_security_group" {
    type        = string
    description = "Azure network security group"
}

variable "security_rule_name" {
    type        = string
    description = "Azure network security rule"
}

variable "network_interface_name" {
    type        = string
    description = "Azure network interface"
}

variable "public_ip_address" {
    type        = string
    description = "Azure public ip address"
}

variable "vm_name_prefix" {
    type = string
    description = "Azure VM name"
}



# variable "security_rule_name1" {
#     type        = string
#     description = "Azure network security rule1"
# }

# variable "security_rule_name2" {
#     type        = string
#     description = "Azure network security rule2"
# }

# variable "security_rule_name3" {
#     type        = string
#     description = "Azure network security rule1"
# }


variable "destination_port_range" {
    type        = list
    description = "Azure network security rule1"
    default = [
        "80",
        "3389",
        "5985",
        "5986"
    ]
}

variable "subnet_prefix" {
    description = "my subnet prefixes"
    default = [
        "192.168.1.0/24",
        "192.168.2.0/24",
        "192.168.3.0/24"
    ]
}