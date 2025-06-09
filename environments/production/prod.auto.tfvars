tags = {
  environment = "production"
  app         = "todo"
}

resource_groups = {
  rg-todo-app-prod = {
    location = "Canada Central"
  }
}

# virtual_networks = {
#   vnet-prod = {
#     resource_group_name = "rg-todo-app-prod"
#     address_space       = "10.60.0.0/16"
#     subnets = {
#       frontend = {
#         address_prefix = "10.60.0.0/24"
#       }
#       backend = {
#         address_prefix = "10.60.1.0/24"
#       }
#     }
#   }
# }

# vms = {
#   web-vm = {
#     resource_group_name  = "rg-todo-app-prod"
#     virtual_network_name = "vnet-prod"
#     subnet_name          = "frontend"
#     size                 = "Standard_B1s"
#     is_public_ip_needed  = true
#     custom_data          = "../../scripts/nginx.sh"
#     public_key           = "../../keys/fevm.pub"
#     inbound_ports        = [80, 22]
#   }
#   backend-vm = {
#     resource_group_name  = "rg-todo-app-prod"
#     virtual_network_name = "vnet-prod"
#     subnet_name          = "backend"
#     size                 = "Standard_B1s"
#     is_public_ip_needed  = true
#     custom_data          = "../../scripts/python.sh"
#     public_key           = "../../keys/bevm.pub"
#     inbound_ports        = [8000, 22]
#   }
# }

# mssql_databases = {
#   todoprod = {
#     resource_group_name = "rg-todo-app-prod"
#     username            = "databaseuser"
#     existing_key_vault = {
#       name                = "todo-vault-rudra"
#       resource_group_name = "rg-rudra"
#       secret_key          = "TODO-DB-PWD-PROD"
#     }
#     databases = {
#       todo = {}
#     }
#   }
# }

# storage_accounts = {
#   sa6060 = {
#     resource_group_name      = "rg-todo-app-prod"
#     account_replication_type = "LRS"
#   }
# }
