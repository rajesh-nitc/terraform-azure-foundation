locals {
  mg_id     = data.azurerm_management_group.mg.id
  sub_name  = data.azurerm_subscriptions.all.subscriptions[0].display_name
  sub_id    = data.azurerm_subscriptions.all.subscriptions[0].subscription_id
  id        = data.azurerm_subscriptions.all.subscriptions[0].id
  tenant_id = data.azurerm_client_config.current.tenant_id

  rg_name = azurerm_resource_group.rg.name

  uai_roles = flatten([
    for k, v in var.uai_roles : [
      for i in v : { member = k, role = i }
    ]
  ])

  group_roles = flatten([
    for k, v in var.group_roles : [
      for i in v : { member = k, role = i }
    ]
  ])

  # filter repos that include "cicd". This leaves us with [infra/web/api]-cicd repos.
  filtered_cicd_repos = { for k, v in var.uai_repos : k => v if can(regex(".*cicd.*", k)) }

  # filter repos that include "cicd" but not "infra". This leaves us with [web/api]-cicd repos.
  filtered_app_cicd_repos = { for k, v in var.uai_repos : k => v if can(regex(".*cicd.*", k)) && !can(regex(".*infra.*", k)) }

  # This leaves us with [web]-cicd repos for which we need azure app registration. api don't require auth
  filtered_app_cicd_web_repos = { for k, v in local.filtered_app_cicd_repos : k => v if !can(regex(".*api.*", k)) }

}