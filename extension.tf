resource "azurerm_virtual_machine_extension" "virtual_machine_extension" {
  count                = (length(var.file_uris) >= 0) ? 1 : 0
  name                 = "CustomScriptExtension"
  location             = azurerm_virtual_machine.vm.location
  resource_group_name  = azurerm_virtual_machine.vm.resource_group_name
  virtual_machine_name = azurerm_virtual_machine.vm.name
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
         "fileUris": ["${var.file_uris}"]
    }
  SETTINGS

  protected_settings = <<SETTINGS
    {
        "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File ${var.file_name}"
    }
    SETTINGS
}
