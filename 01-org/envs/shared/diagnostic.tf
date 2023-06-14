# This cannot be configured at management group level using terraform yet
# Hence, configuring it at subscription level
resource "azurerm_monitor_diagnostic_setting" "logs" {
  for_each           = var.subscriptions
  provider           = azurerm.common-management
  name               = "diag-${each.key}"
  target_resource_id = "/subscriptions/${each.value}"

  log_analytics_workspace_id     = azurerm_log_analytics_workspace.law.id
  log_analytics_destination_type = "Dedicated"

  dynamic "enabled_log" {
    for_each = var.log_categories
    content {
      category = enabled_log.value

      retention_policy {
        enabled = false
      }
    }
  }
}