data "azurerm_subnet" "subnet" {
  name                 = "workstation"
  virtual_network_name = var.v_net
  resource_group_name  = var.resource_group_name
}
