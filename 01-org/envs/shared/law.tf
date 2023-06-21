# law
resource "azurerm_resource_group" "law" {
  provider = azurerm.sub-common-management
  name     = module.naming.resource_group.name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  provider            = azurerm.sub-common-management
  name                = module.naming.log_analytics_workspace.name
  location            = azurerm_resource_group.law.location
  resource_group_name = azurerm_resource_group.law.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# law solutions
resource "azurerm_log_analytics_solution" "solutions" {
  provider              = azurerm.sub-common-management
  for_each              = { for i in var.law_solutions : i.name => i }
  solution_name         = each.key
  location              = azurerm_resource_group.law.location
  resource_group_name   = azurerm_resource_group.law.name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = each.value.publisher
    product   = each.value.product
  }


}
