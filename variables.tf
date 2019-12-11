variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Virtual Machine. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created."
}

variable "subnet_id" {
  type        = string
  description = "(Required) Reference to a subnet in which this Virtual Machine has been created."
}

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

variable "os_profile_windows_config" {
  type        = map(string)
  description = "(Optional) To configure windows profile."
  default = {
    enable_automatic_upgrades = true
    provision_vm_agent        = true                      # Required VM Agent to execute Azure virtual machine extensions.
    timezone                  = "Singapore Standard Time" # Specifies the time zone of the virtual machine, the possible values are defined http://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/
  }
}

variable "vm_size" {
  type        = string
  description = "(Optional) Specifies the size of the Virtual Machine."
  default     = "Standard_D4s_v3"
}

variable "fqdn" {
  type        = string
  description = "(Required) FQDN"
}

variable "admin_username" {
  type        = string
  description = "(Required) OS admin name for remote access."
}

variable "admin_password" {
  type        = string
  description = "(Required) OS admin password for remote access."
}

variable "boot_diagnostics" {
  description = "(Optional) Enable or Disable boot diagnostics"
  default     = true
}

variable "tags" {
  description = "(Required) Map of tags for the deployment"
}

variable "file_uris" {
  type        = string
  description = "(Optional) Azure Virtual Machine CustomScriptExtension file URIs"
  default     = ""
}

variable "file_name" {
  type        = string
  description = "(Optional) Azure Virtual Machine CustomScriptExtension file name"
  default     = ""
}
