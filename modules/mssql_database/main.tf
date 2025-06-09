data "azurerm_key_vault" "key-vault" {
  name                = var.existing_key_vault.name
  resource_group_name = var.existing_key_vault.resource_group_name
}

data "azurerm_key_vault_secret" "db-pwd" {
  name         = var.existing_key_vault.secret_key
  key_vault_id = data.azurerm_key_vault.key-vault.id
}

resource "azurerm_mssql_server" "server" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = data.azurerm_key_vault_secret.db-pwd.value
  tags                         = var.tags
}

resource "azurerm_mssql_database" "database" {
  for_each     = var.databases
  name         = each.key
  server_id    = azurerm_mssql_server.server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure_resources" {
  name             = "AllowAllAzureResources"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
