terraform {
    backend "azurerm" {
        resource_group_name   = "tf_state_rg5269"
        storage_account_name  = "tfstatestorage5269"
        container_name        = "tfstatecontainer5269"
        key                   = "terraform.tfstatefile" # the file to create 

    }

}