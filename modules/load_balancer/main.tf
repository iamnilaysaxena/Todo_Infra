resource "azurerm_public_ip" "pip" {
  name                = "${var.frontend_ip_configuration_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_lb" "lb" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  for_each        = var.backend_pools
  loadbalancer_id = azurerm_lb.lb.id
  name            = each.key
}

resource "azurerm_lb_rule" "rule" {
  for_each                       = var.backend_pools
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "${each.key}-rule"
  protocol                       = "Tcp"
  frontend_port                  = each.value.port
  backend_port                   = each.value.port
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  probe_id                       = azurerm_lb_probe.probe[each.key].id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool[each.key].id]
}

resource "azurerm_lb_probe" "probe" {
  for_each        = var.backend_pools
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${each.key}-probe"
  port            = each.value.port
}


resource "azurerm_network_interface_backend_address_pool_association" "map" {
  for_each                = transpose({ for k, v in var.backend_pools : k => v.vms })
  network_interface_id    = var.vm_nicid_mapping[each.key]
  ip_configuration_name   = "${each.key}-ip"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool[each.value[0]].id
}

