resource "azurerm_container_app_environment" "env" {
  name                           = format("%s-%s-%s-%s-%s", "cae", var.bu, var.app, var.env, var.location)
  resource_group_name            = local.rg_name
  location                       = var.location
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.law.id
  infrastructure_subnet_id       = data.azurerm_subnet.infra.id
  internal_load_balancer_enabled = true
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = format("%s-%s", module.naming.log_analytics_workspace.name, "aca")
  location            = var.location
  resource_group_name = local.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_private_dns_zone" "dns" {
  name                = format("%s-%s", module.naming.private_dns_zone.name, "aca")
  resource_group_name = local.rg_net_name
}

resource "azurerm_private_dns_a_record" "record" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.dns.name
  resource_group_name = local.rg_net_name
  ttl                 = 60
  records             = [azurerm_container_app_environment.env.static_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_link" {
  name                  = format("%s-%s", azurerm_private_dns_zone.dns.name, "link")
  resource_group_name   = local.rg_net_name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = data.azurerm_virtual_network.spoke_vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub_link" {
  name                  = format("%s-%s", azurerm_private_dns_zone.dns.name, "link")
  resource_group_name   = local.rg_net_name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = data.azurerm_virtual_network.hub_vnet.id
}