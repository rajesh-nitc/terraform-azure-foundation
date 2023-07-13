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

  # app means [web-e-auth/web-e]

  # filter repos that include "cicd". This leaves us with [infra/web-e-auth/web-e]-cicd repos.
  filtered_cicd_repos = { for k, v in var.uai_repos : k => v if can(regex(".*cicd.*", k)) }

  # filter repos that include "cicd" but not "infra". This leaves us with [web-e-auth/web-e]-cicd repos.
  filtered_app_cicd_repos = { for k, v in var.uai_repos : k => v if can(regex(".*cicd.*", k)) && !can(regex(".*infra.*", k)) }

  # filter repos that does not include "infra" and "cicd". This leaves us with [web-e-auth/web-e] repos.
  filtered_app_repos = { for k, v in var.uai_repos : k => v if !can(regex(".*cicd.*", k)) && !can(regex(".*infra.*", k)) }

  # filter repos that include just the web-e-auth so that we can create app registrations for them
  filtered_app_web_e_auth_repos = { for k, v in var.uai_repos : k => v if can(regex(".*auth.*", k)) && !can(regex(".*cicd.*", k)) && !can(regex(".*infra.*", k)) }

}