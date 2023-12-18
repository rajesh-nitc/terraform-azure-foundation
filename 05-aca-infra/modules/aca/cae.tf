# # module naming does not support container_app_environment
# resource "azurerm_container_app_environment" "env" {
#   name                           = format("%s-%s-%s-%s-%s", "cae", var.bu, var.app, var.location, var.env)
#   resource_group_name            = local.rg_name
#   location                       = var.location
#   log_analytics_workspace_id     = data.azurerm_log_analytics_workspace.law.id
#   infrastructure_subnet_id       = data.azurerm_subnet.infra.id
#   internal_load_balancer_enabled = false
# }

# # resource "azurerm_private_dns_zone" "dns" {
# #   name                = azurerm_container_app_environment.env.default_domain
# #   resource_group_name = local.rg_net_name
# # }

# # resource "azurerm_private_dns_a_record" "record" {
# #   name                = "*"
# #   zone_name           = azurerm_private_dns_zone.dns.name
# #   resource_group_name = local.rg_net_name
# #   ttl                 = 60
# #   records             = [azurerm_container_app_environment.env.static_ip_address]
# # }

# # resource "azurerm_private_dns_zone_virtual_network_link" "spoke_link" {
# #   name                  = format("%s-%s-%s-%s-%s-%s", "pnetlk", "aca", var.bu, var.app, var.location, var.env)
# #   resource_group_name   = local.rg_net_name
# #   private_dns_zone_name = azurerm_private_dns_zone.dns.name
# #   virtual_network_id    = data.azurerm_virtual_network.spoke_vnet.id
# # }