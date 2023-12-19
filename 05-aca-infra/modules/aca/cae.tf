# # module naming does not support container_app_environment
# resource "azurerm_container_app_environment" "env" {
#   name                           = format("%s-%s-%s-%s-%s", "cae", var.bu, var.app, var.location, var.env)
#   resource_group_name            = local.rg_name
#   location                       = var.location
#   log_analytics_workspace_id     = data.azurerm_log_analytics_workspace.law.id
#   infrastructure_subnet_id       = data.azurerm_subnet.infra.id
#   internal_load_balancer_enabled = false
# }