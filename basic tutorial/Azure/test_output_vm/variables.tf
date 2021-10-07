variable "windows_vm_count" {
    type = number
    default = 2
}

variable "resource_group_name" {
    type        = string
    # default     = ["pw_rg1","pw_rg2"]
    description = "RG name in Azure"
}

variable "resource_group_location" {
    type        = string
    description = "RG location in Azure"
    default =  "pw5269resourcegroup"

}

variable "destination_port_range_list" {
    type        = list(string)
    description = "Azure network security rule1"
    default = [
        "80",
        "3389",
        "5985",
        "5986"
    ]
}

variable "destination_port_range_map" {
    type        = map(string)
    description = "Azure network security rule1"
    default =  {
        "101" : "80"
        "102" :"3389"
        "103" :"5985"
        "101" :"5986"
        }
    
}

variable "subnet_prefix" {
    type = list(string)
    description = "my subnet prefixes"
    default = [
         "192.168.1.0/24",
         "192.168.2.0/24",
         "192.168.3.0/24"
    ]
}

