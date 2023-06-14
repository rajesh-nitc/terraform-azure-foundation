# law
resource "azurerm_resource_group" "law" {
  provider = azurerm.common-management
  name     = "rg-common-law"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  provider            = azurerm.common-management
  name                = "law-common"
  location            = azurerm_resource_group.law.location
  resource_group_name = azurerm_resource_group.law.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# law solutions
resource "azurerm_log_analytics_solution" "solutions" {
  provider              = azurerm.common-management
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
