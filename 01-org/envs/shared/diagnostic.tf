# This cannot be configured at management group level using terraform yet
# Hence, configuring it at subscription level
resource "azurerm_monitor_diagnostic_setting" "logs" {
  for_each           = { for i in local.subscriptions_all : i.display_name => i }
  provider           = azurerm.common-management
  name               = "diag-${each.key}"
  target_resource_id = "/subscriptions/${each.value.subscription_id}"

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

  depends_on = [
    # Configure diagnostic after we change the name of the subscription 
    azurerm_subscription.management
  ]
}