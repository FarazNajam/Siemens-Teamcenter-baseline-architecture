resource_group_name = "t-aue-teamcenter-rg"
location            = "australiaeast"

vnet_name     = "t-aue-teamcenter-vnet"
address_space = ["10.0.0.0/16"]

public_ip = "t-aue-teamcenter-appgw_publicIP"

appgw = "t-aue-teamcenter-appgw"

frontend_port = 80

subnets = {
  appgw-subnet = {
    address_prefixes = ["10.0.1.0/24"]
  }

  web-subnet = {
    address_prefixes = ["10.0.2.0/24"]
  }

  enterprise-subnet = {
    address_prefixes = ["10.0.3.0/24"]
  }

  database-subnet = {
    address_prefixes = ["10.0.4.0/24"]
  }
}


vms = {
  web_vm01 = {
    vm_size          = "Standard_B1s"
    subnet           = "web-subnet"
    nic              = "web-vm-nic"
    ip_configuration = "web-vm-ipconfig"
  }

  enterprise_vm01 = {
    vm_size          = "Standard_B1s"
    subnet           = "enterprise_subnet"
    nic              = "enterprise-vm-nic"
    ip_configuration = "web-vm-ipconfig"
  }
}

keyvault_name = "t-aue-teamcenter-kv"

sql_server_name = "t-aue-teamcenter-sqlserver"

sql_database = "t-aue-teamcenter-sqldatabase"

#############
