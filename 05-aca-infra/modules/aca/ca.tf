resource "azurerm_container_app" "ca" {
  for_each                     = var.apps
  name                         = format("%s-%s-%s-%s-%s-%s", "ca", var.bu, var.app, each.key, var.location, var.env)
  resource_group_name          = local.rg_name
  container_app_environment_id = azurerm_container_app_environment.env.id

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.uai[each.key].id]
  }

  revision_mode = "Single"

  ingress {
    allow_insecure_connections = false
    external_enabled           = each.value.external
    target_port                = each.value.target_port
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    container {
      name   = format("%s-%s-%s-%s-%s", var.bu, var.app, each.key, var.location, var.env)
      cpu    = "0.25"
      memory = "0.5Gi"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"

    }

    min_replicas = 1
    max_replicas = 2
  }

  lifecycle {
    ignore_changes = [
      template[0].container[0].image,
    ]
  }

}