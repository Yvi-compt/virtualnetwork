resource "azurerm_resource_group" "yvesmcitrg" {
  name     = "yves-waf-resource-group"
  location = "Eastus"
}

resource "azurerm_application_gateway" "yvesappgw" {
  name                = "yvesAppGateway"
  location            = azurerm_resource_group.yvesmcitrg.location
  resource_group_name = azurerm_resource_group.yvesmcitrg.name

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-config"
    subnet_id = azurerm_subnet.subnetb.id
  }

  frontend_ip_configuration {
    name                 = "my-frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  frontend_port {
    name = "my-frontend-port"
    port = 80
  }

  http_listener {
    name                           = "my-listener"
    frontend_ip_configuration_name = "my-frontend-ip-config"
    frontend_port_name             = "my-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "my-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "my-listener"
    backend_address_pool_name  = "my-backend-pool"
    backend_http_settings_name = "my-backend-http-settings"
  }

  backend_address_pool {
    name = "my-backend-pool"
  }

  backend_http_settings {
    name                  = "my-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }
}

resource "azurerm_public_ip" "appgw_pip" {
  name                = "appgw-public-ip"
  location            = azurerm_resource_group.yvesmcitrg.location
  resource_group_name = azurerm_resource_group.yvesmcitrg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network" "vnetb" {
  name                = "waf-vnet"
  location            = azurerm_resource_group.yvesmcitrg.location
  resource_group_name = azurerm_resource_group.yvesmcitrg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnetb" {
  name                 = "yvesmcit-waf-subnet"
  resource_group_name  = azurerm_resource_group.yvesmcitrg.name
  virtual_network_name = azurerm_virtual_network.vnetb.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = "yvesWAFPolicy"
  resource_group_name = azurerm_resource_group.yvesmcitrg.name
  location            = azurerm_resource_group.yvesmcitrg.location

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  custom_rules {
    name      = "BlockMaliciousIPs"
    priority  = 1
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }
      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["192.168.1.1", "10.0.0.1"]
    }

    action = "Block"
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}
