resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "southeastasia"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  tags = {
    Env = "Demo"
    DR  = "NONE"
  }
}

module "virtual_machine" {
  source              = "../../"
  name                = "example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  fqdn                = "example"
  subnet_id           = element(azurerm_virtual_network.example.subnet.*.id, 0)
  admin_username      = "admin123"
  admin_password      = "adMin%6541"
  file_uris           = "https://gist.githubusercontent.com/melvinlee/508f6c42a3d274532d56aec2a96483b3/raw/17528260c14f9c1bc7f873e6631cc4678449633f/bootstrap.ps1"
  file_name            = "bootstrap.ps1"
  tags = {
    Env = "Demo"
    DR  = "NONE"
  }
}
