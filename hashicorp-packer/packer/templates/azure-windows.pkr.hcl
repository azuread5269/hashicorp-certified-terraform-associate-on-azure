source "azure-arm" "windows" {
  client_id = "a9d85e3e-105d-4375-894e-1086362f02c9"
  client_secret = "w2E7Q~1NUKFekO88RKHR64v_uo7Oi46NJdyiK"
  resource_group_name = "pw5269resourcegroup"
  storage_account = "pw5269storage"
  subscription_id = "b312c3d5-5b7c-4ab6-ae52-2b3a94b9c232"
  tenant_id = "d4cfe037-3ef4-42d7-a3f8-74f292af0782"


  os_type         = "windows"
  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = "2016-Datacenter"

    capture_container_name = "images"
    capture_name_prefix = "packer"

  azure_tags = {
    Created-By = "Phil Waller"
    OS_Version = "Windows 2016"
    Release    = "Latest"

  }

  location = "ukwest"
  vm_size  = "Standard_B1ms"

}

  build {
    name = "Pwaller-VM"
    sources = [
      "source.azure-arm.windows"
    ]
  }



  #      publisher = "MicrosoftWindowsServer"
  #  offer     = "WindowsServer"
  #  sku       = "2016-Datacenter"
  #  version   = "latest"

