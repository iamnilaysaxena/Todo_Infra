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

variable "databases" {
  type = map(object({}))
}

variable "administrator_login" {
  type = string
}

variable "existing_key_vault" {
  type = object({
    name                = string
    resource_group_name = string
    secret_key          = string
  })
}
