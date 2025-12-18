module "resource_groups" {
  for_each = var.resource_groups
  source   = "../../modules/resource_group"
  name     = each.key
  location = each.value.location
  tags     = var.tags
}


module "virtual_networks" {
  for_each            = var.virtual_networks
  source              = "../../modules/virtual_network"
  name                = each.key
  resource_group_name = module.resource_groups[each.value.resource_group_name].name
  location            = module.resource_groups[each.value.resource_group_name].location
  address_space       = each.value.address_space
  subnets             = each.value.subnets
  tags                = var.tags
}

module "vms" {
  for_each            = var.vms
  source              = "../../modules/vm"
  name                = each.key
  subnet_id           = module.virtual_networks[each.value.virtual_network_name].subnet_ids[each.value.subnet_name]
  resource_group_name = module.resource_groups[each.value.resource_group_name].name
  location            = module.resource_groups[each.value.resource_group_name].location
  size                = each.value.size
  public_key          = file(each.value.public_key)
  custom_data         = each.value.custom_data
  is_public_ip_needed = each.value.is_public_ip_needed
  inbound_ports       = each.value.inbound_ports
  tags                = var.tags
}

# module "storage_accounts" {
#   for_each                 = var.storage_accounts
#   source                   = "../../modules/storage_account"
#   name                     = each.key
#   resource_group_name      = module.resource_groups[each.value.resource_group_name].name
#   location                 = module.resource_groups[each.value.resource_group_name].location
#   account_replication_type = each.value.account_replication_type
#   tags                     = var.tags
# }

#module "mssql_databases" {
#  for_each            = var.mssql_databases
#  source              = "../../modules/mssql_database"
#  name                = each.key
#  administrator_login = each.value.username
#  resource_group_name = module.resource_groups[each.value.resource_group_name].name
#  location            = module.resource_groups[each.value.resource_group_name].location
#  databases           = each.value.databases
#  tags                = var.tags
#  existing_key_vault  = each.value.existing_key_vault
#}

# module "load_balancers" {
#   for_each                       = var.load_balancers
#   source                         = "../../modules/load_balancer"
#   name                           = each.key
#   resource_group_name            = module.resource_groups[each.value.resource_group_name].name
#   location                       = module.resource_groups[each.value.resource_group_name].location
#   tags                           = var.tags
#   frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
#   backend_pools                  = each.value.backend_pools
#   vm_nicid_mapping               = { for k, v in module.vms : k => v.nicid }
# }
