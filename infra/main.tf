
locals {
  appgw = {
    gateway_ip_config  = "appgw-ip-config"
    frontend_ip_config = "appgw-frontend-ip"
    frontend_port      = "http-port"
    backend_pool       = "web-backend"
    backend_settings   = "web-http-settings"
    listener           = "http-listener"
    routing_rule       = "http-routing-rule"
  }
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = local.appgw.gateway_ip_config
    subnet_id = azurerm_subnet.subnets["appgw-subnet"].id
  }

  frontend_port {
    name = local.appgw.frontend_port
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = local.appgw.frontend_ip_config
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = local.appgw.backend_pool

    backend_address {
      ip_address = azurerm_network_interface.web_vm01.private_ip_address
    }
  }

  backend_http_settings {
    name                  = local.appgw.backend_settings
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.appgw.listener
    frontend_ip_configuration_name = local.appgw.frontend_ip_config
    frontend_port_name             = local.appgw.frontend_port
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.appgw.routing_rule
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.appgw.listener
    backend_address_pool_name  = local.appgw.backend_pool
    backend_http_settings_name = local.appgw.backend_settings
  }
}

#