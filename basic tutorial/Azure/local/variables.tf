variable "windows_vm_count" {
    type = number
    default = 2
}

variable "resource_group_name1" {
    type        = list(map(string))
    default     = [
        {
            Name = "pw_rg1"
            age  = 52
        },
        {
            Name = "pw_rg2"
            age = 50
        }
            
        ]
    description = "RG name in Azure"
}

variable "resource_group_name2" {
    type        = set(string)
    default     = ["pw_rg1","pw_rg2"]
    description = "RG name in Azure"
}

variable "resource_group_location" {
    type        = string
    description = "RG location in Azure"
    default =  "pw5269resourcegroup"

}