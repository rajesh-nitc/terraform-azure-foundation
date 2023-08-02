# module naming does not support container_app_environment
resource "azurerm_container_app_environment" "env" {
  name                           = format("%s-%s-%s-%s-%s", "cae", var.bu, var.app, var.location, var.env)
  resource_group_name            = local.rg_name
  location                       = var.location
  log_analytics_workspace_id     = data.azurerm_log_analytics_workspace.law.workspace_id
  infrastructure_subnet_id       = data.azurerm_subnet.infra.id
  internal_load_balancer_enabled = var.deploy_appgw ? true : false
}

resource "azurerm_private_dns_zone" "dns" {
  count               = var.deploy_appgw ? 1 : 0
  name                = azurerm_container_app_environment.env.default_domain
  resource_group_name = local.rg_net_name
}

resource "azurerm_private_dns_a_record" "record" {
  count               = var.deploy_appgw ? 1 : 0
  name                = "*"
  zone_name           = azurerm_private_dns_zone.dns[count.index].name
  resource_group_name = local.rg_net_name
  ttl                 = 60
  records             = [azurerm_container_app_environment.env.static_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_link" {
  count                 = var.deploy_appgw ? 1 : 0
  name                  = format("%s-%s-%s-%s", "pnetlk", "aca", var.bu, var.app, var.location, var.env)
  resource_group_name   = local.rg_net_name
  private_dns_zone_name = azurerm_private_dns_zone.dns[count.index].name
  virtual_network_id    = data.azurerm_virtual_network.spoke_vnet.id
}