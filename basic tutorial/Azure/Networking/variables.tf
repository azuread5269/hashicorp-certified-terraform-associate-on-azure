variable "resource_group_name" {
    type        = string
    # default     = ["pw_rg1","pw_rg2"]
    description = "RG name in Azure"
}

variable "resource_group_location" {
    type        = string
    description = "RG location in Azure"
}

variable "storage_account_name" {
    type        = string
    description = "Storage Account in Azure"
}

variable "account_tier" {
    type        = string
    description = "Storage account type in Azure"
}

variable "account_replication_type" {
    type        = string
    default     = "LRS"
    description = "Storage account replication type in Azure"
}
