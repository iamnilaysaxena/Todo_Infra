output "rg_ids" {
  value = { for rg, value in module.resource_groups : rg => value.id }
}

output "vnet_ids" {
  value = { for vnet, value in module.virtual_networks : vnet => value.id }
}

output "vm_ids" {
  value = { for vm, value in module.vms : vm =>
    {
      id        = value.id
      privateip = value.privateip
      publicip  = value.publicip
    }
  }
}

output "sa_ids" {
  value = { for sa, value in module.storage_accounts : sa => value.id }
}
