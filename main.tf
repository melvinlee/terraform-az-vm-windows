resource "random_id" "id" {
  keepers = {
    name = var.name
  }
  byte_length = 6
}

resource "random_integer" "int" {
  min = 001
  max = 999
}

# Allocate a Public IP address for your Virtual Machine for remote access
resource "azurerm_public_ip" "ip" {
  name                = "pip-${var.name}-${random_integer.int.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = null

  tags = local.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.name}-${random_integer.int.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  //network_security_group_id = azurerm_network_security_group.nsg.id

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }

  tags = local.tags

  depends_on = [azurerm_public_ip.ip]
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "bootdiag${lower(random_id.id.hex)}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_virtual_machine" "vm" {
  name                          = "vm-${var.name}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  network_interface_ids         = [azurerm_network_interface.nic.id]
  vm_size                       = var.vm_size
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = var.image["publisher"]
    offer     = var.image["offer"]
    sku       = var.image["sku"]
    version   = var.image["version"]
  }

  storage_os_disk {
    name              = "osdisk-${var.name}${lower(random_id.id.hex)}"
    managed_disk_type = "Premium_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = var.name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    enable_automatic_upgrades = lookup(var.os_profile_windows_config, "enable_automatic_upgrades",true)
    provision_vm_agent        = lookup(var.os_profile_windows_config, "provision_vm_agent",true)                     
    timezone                  = lookup(var.os_profile_windows_config, "timezone","")
  }

  boot_diagnostics {
    enabled     = var.boot_diagnostics
    storage_uri = var.boot_diagnostics == true ? azurerm_storage_account.storage_account.primary_blob_endpoint : ""
  }

  tags = local.tags

  depends_on = [azurerm_network_interface.nic]
}
