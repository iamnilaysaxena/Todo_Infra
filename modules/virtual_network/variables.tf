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


variable "address_space" {
  type = string
}

variable "subnets" {
  type = map(object({
    address_prefix = string
  }))
}
