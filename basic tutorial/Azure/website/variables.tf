variable "resource_group_name" {
    type        = string
    description = "RG name in Azure"
}

variable "resource_group_location" {
    type        = string
    description = "RG location in Azure"
}

variable "account_tier" {
    type        = string
    description = "Storage account type in Azure"
}

variable "account_replication_type" {
    type        = string
    description = "Storage account replication type in Azure"
}
