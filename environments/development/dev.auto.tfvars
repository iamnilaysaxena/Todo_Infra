tags = {
  environment = "development"
  app         = "todo"
}

resource_groups = {
  rg-todo-app-dev = {
    location = "Canada Central"
  }
}

virtual_networks = {
  vnet-dev = {
    resource_group_name = "rg-todo-app-dev"
    address_space       = "10.60.0.0/16"
    subnets = {
      frontend = {
        address_prefix = "10.60.0.0/24"
      }
      backend = {
        address_prefix = "10.60.1.0/24"
      }
    }
  }
}

vms = {
  web-vm = {
    resource_group_name  = "rg-todo-app-dev"
    virtual_network_name = "vnet-dev"
    subnet_name          = "frontend"
    size                 = "Standard_B1s"
    is_public_ip_needed  = true
    custom_data          = "../../scripts/nginx.sh"
    public_key           = "../../keys/fevm.pub"
    inbound_ports        = [80, 22]
  }
  backend-vm = {
    resource_group_name  = "rg-todo-app-dev"
    virtual_network_name = "vnet-dev"
    subnet_name          = "backend"
    size                 = "Standard_B1s"
    is_public_ip_needed  = true
    custom_data          = "../../scripts/python.sh"
    public_key           = "../../keys/bevm.pub"
    inbound_ports        = [8000, 22]
  }
}

mssql_databases = {
  tododev = {
    resource_group_name = "rg-todo-app-dev"
    username            = "databaseuser"
    existing_key_vault = {
      name                = "todo-vault-rudra"
      resource_group_name = "rg-rudra"
      secret_key          = "TODO-DB-PWD-DEV"
    }
    databases = {
      todo = {}
    }
  }
}

# storage_accounts = {
#   sa6060 = {
#     resource_group_name      = "rg-todo-app-dev"
#     account_replication_type = "LRS"
#   }
# }
