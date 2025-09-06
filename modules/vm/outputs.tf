output "id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "privateip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "publicip" {
  value = var.is_public_ip_needed ? azurerm_public_ip.pip[0].ip_address : null
}

output "nicid" {
  value = azurerm_network_interface.nic.id
}
