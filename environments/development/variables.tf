variable "tags" {
  type    = map(string)
  default = {}
} 

variable "resource_groups" {
  type = map(object({
    location = string
  }))
  default = {}
}

variable "virtual_networks" {
  type = map(object({
    resource_group_name = string
    address_space       = string
    subnets = map(object({
      address_prefix = string
    }))
  }))
  default = {}
}

variable "vms" {
  type = map(object({
    resource_group_name  = string
    virtual_network_name = string
    subnet_name          = string
    size                 = string
    is_public_ip_needed  = optional(bool, false)
    custom_data          = optional(string)
    public_key           = string
    inbound_ports        = optional(list(string), [])
  }))
  default = {}
}

variable "mssql_databases" {
  type = map(object({
    resource_group_name = string
    username            = string
    databases           = optional(map(object({})))
    existing_key_vault = object({
      name                = string
      resource_group_name = string
      secret_key          = string
    })
  }))
  default = {}
}

variable "storage_accounts" {
  type = map(object({
    resource_group_name      = string
    account_replication_type = string
  }))
  default = {}
}
