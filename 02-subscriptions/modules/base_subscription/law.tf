resource "azurerm_log_analytics_workspace" "law" {
  name                = module.naming.log_analytics_workspace.name
  location            = var.location
  resource_group_name = local.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}