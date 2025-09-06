variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "frontend_ip_configuration_name" {
  type = string
}

variable "backend_pools" {
  type = map(object({
    port = number
    vms  = list(string)
  }))
}

variable "vm_nicid_mapping" {
  type = map(string)
}
