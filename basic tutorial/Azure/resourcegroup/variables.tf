#these declerations can actually be empty - below is just declaring what variable type, i.e. String or bool
# the variables are then declared inside the .tfvars - so you could have multiple deployments, i.e. staging.tfvars and production.tfvars


variable "resource_group_name" {

}

variable "resource_group_location" {

}

# variable "resource_group_name" {
#     type        = string
#     description = "RG name in Azure"
# }

# variable "resource_group_location" {
#     type        = string # 
#     description = "RG location in Azure"
# }
