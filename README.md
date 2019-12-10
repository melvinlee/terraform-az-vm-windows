# Create Azure VM 

Reference the module to a specific version (recommended):

```
module "virtual_machine" {
    source = "git://github.com/melvinlee/terraform-az-vm-windows.git?ref=v0.1"

    name                = var.name
    location            = var.location
    resource_group_name = var.resource_group_name
    ...
}
```

Or get the latest version

```sh
source = "git://github.com/melvinlee/terraform-az-vm-windows.git?ref=latest"
```

# Parameters

## name
```sh
variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Virtual Machine. Changing this forces a new resource to be created."
}
```

## resource_group_name
```sh
variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}
```

## location
```sh
variable "location" {
  type        = string
  description = "(Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}
```

## subnet_id
```sh
variable "subnet_id" {
  type        = string
  description = "(Required) Reference to a subnet in which this Virtual Machine has been created."
}
```

## image
```sh
variable "image" {
  type        = map(string)
  description = "(Optional) To provision vm from an Azure Platform Image."
  default = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "rs4-pro"
    version   = "latest"
  }
}
```

## os_profile_windows_config
```sh
variable "os_profile_windows_config" {
  type        = map(string)
  description = "(Optional) To configure windows profile."
  default = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true                      # Required VM Agent to execute Azure virtual machine extensions.
    timezone                  = "Singapore Standard Time" # Specifies the time zone of the virtual machine, the possible values are defined http://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/
  }
}
```

Example: to disable azure vm agent provisioning and automatic_upgrades

```sh
 os_profile_windows_config = {
    enable_automatic_upgrades = false
    provision_vm_agent        = false
  }
```

## vm_size
```sh
variable "vm_size" {
  type        = string
  description = "(Optional) Specifies the size of the Virtual Machine."
  default     = "Standard_D4s_v3"
}
```

## fqdn
```sh
variable "fqdn" {
  type        = string
  description = "(Required) FQDN"
}
```

## admin_username
```sh
variable "admin_username" {
  type        = string
  description = "(Required) OS admin name for remote access."
}
```

## admin_password
```sh
variable "admin_password" {
  type        = string
  description = "(Required) OS admin password for remote access."
}
```

## boot_diagnostics
```sh
variable "boot_diagnostics" {
  description = "(Optional) Enable or Disable boot diagnostics"
  default     = true
}
```

## tags
```sh
variable "tags" {
  description = "(Required) Map of tags for the deployment"
}
```

# Output


# Contribute

Pull requests are welcome to evolve this module and integrate new features.