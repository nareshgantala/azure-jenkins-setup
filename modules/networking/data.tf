data "azurerm_subnet" "subnet" {
  name                 = "workstation"
  virtual_network_name = var.v_net
  resource_group_name  = var.resource_group_name
}

data "azurerm_network_security_group" "allow-all" {
  name                = "allow-all"
  resource_group_name = var.resource_group_name
}
