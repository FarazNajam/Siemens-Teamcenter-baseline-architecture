variable "subnets" {
  description = "Subnet definitions"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "appgw" {
  type = string
}

variable "frontend_port" {
  type = number
}

variable "vnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "public_ip" {
  type = string
}

variable "vms" {
  description = "vms in web/enterprise tiers"
  type = map(object({
    vm_size           = string
    subnet            = string
    nic               = string
    ip_configuration  = string
  }))
}

variable "keyvault_name" {
  type = string
}

variable "sql_database" {
  type = string
}

variable "sql_server_name" {
  type = string
}
