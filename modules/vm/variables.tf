variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "size" {
  type = string
}

variable "custom_data" {
  type = string
}

variable "public_key" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "is_public_ip_needed" {
  type = bool
}

variable "inbound_ports" {
  type = list(string)
}

