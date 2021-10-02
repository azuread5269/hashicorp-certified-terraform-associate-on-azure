variable "web_windows_instance_count" {
    type = number
    default = 1
}

variable "lb_nat_inbound_ports" {
    type = list(string)
    default = ["1001","1002","1003","1004","1005"]
}

variable "resource_group_name" {
    type        = string
    # default     = ["pw_rg1","pw_rg2"]
    description = "RG name in Azure"
}

variable "resource_group_location" {
    type        = string
    description = "RG location in Azure"
}