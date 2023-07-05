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

  # filter repos that include "cicd"
  filtered_cicd_repos = { for k, v in var.uai_repos : k => v if can(regex(".*cicd.*", k)) }

  # filter repos that include "cicd" but not "infra"
  filtered_app_cicd_repos = { for k, v in var.uai_repos : k => v if can(regex(".*cicd.*", k)) && !can(regex(".*infra.*", k)) }

  # filter repos that include "app" but not "infra" and "cicd"
  filtered_app_repos = { for k, v in var.uai_repos : k => v if !can(regex(".*cicd.*", k)) && !can(regex(".*infra.*", k)) }

}