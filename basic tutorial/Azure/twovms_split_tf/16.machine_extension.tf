resource "azurerm_virtual_machine_extension" "rglb" {
  count = 2
  name                = "AZ-VM-00-MAEXT"
  virtual_machine_id   = "${azurerm_windows_virtual_machine.rg[count.index].id}"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
#   type_handler_version = "2.1.3"
    type_handler_version = "1.9"

  # CustomVMExtension Documetnation: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows

  settings = <<SETTINGS
    {
        "fileUris": ["https://pw5269scriptstore.blob.core.windows.net/pw5269containerscriptstore/ansiblewinrm.ps1"]


    }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ansiblewinrm.ps1"

    }
  PROTECTED_SETTINGS
  depends_on = [azurerm_windows_virtual_machine.rg]
}

        # "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ansiblewinrm.ps1"
    #   "storageAccountName": "mystorageaccountname",
    #   "storageAccountKey": "myStorageAccountKey"