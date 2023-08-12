# This cannot be configured at management group level
# Error: Can not parse "target_resource_id" as a resource id: No subscription ID found in: "providers/Microsoft.Management/managementGroups/dfeb6941-abde-47b4-8f0e-f0f2fbb4f470"
# Hence, configuring it at subscription level
# Send admin activity logs including var.log_categories to central law
resource "azurerm_monitor_diagnostic_setting" "logs" {
  for_each           = { for i in local.subscriptions_all : i.display_name => i }
  provider           = azurerm.sub-common-management
  name               = format("%s-%s", module.naming.monitor_diagnostic_setting.name, each.key)
  target_resource_id = each.value.id

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

  lifecycle {
    ignore_changes = [
      # looks like a bug, terraform plan always shows a diff
      log_analytics_destination_type,
    ]
  }
}