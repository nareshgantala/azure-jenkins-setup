module "networking" {
  source = "./modules/networking"
  resource_group_name = data.azurerm_resource_group.rsg.name
  location = data.azurerm_resource_group.rsg.location
  v_net = var.v_net
}

module "vm" {
  source = "./modules/vm"
  resource_group_name = data.azurerm_resource_group.rsg.name
  location = data.azurerm_resource_group.rsg.location
  nic_id = module.networking.jenkins_nic_id
}