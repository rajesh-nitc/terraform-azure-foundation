resource "azapi_resource" "root" {
  type      = "Microsoft.Insights/diagnosticSettings@2020-01-01-preview"
  name      = format("%s-%s", module.naming.monitor_diagnostic_setting.name, "logs")
  parent_id = local.scope
  body = jsonencode({
    properties = {
      workspaceId = azurerm_log_analytics_workspace.law.id
      logs        = var.logs
    }
  })
}