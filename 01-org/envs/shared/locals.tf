locals {
  scope                        = data.azurerm_management_group.root.id
  subscriptions_all            = data.azurerm_subscriptions.all.subscriptions
  sub_id_management            = data.azurerm_subscriptions.management.subscriptions[0].subscription_id
  sub_resource_id_management   = data.azurerm_subscriptions.management.subscriptions[0].id
  sub_name_management          = data.azurerm_subscriptions.management.subscriptions[0].display_name
  sub_id_connectivity          = data.azurerm_subscriptions.connectivity.subscriptions[0].subscription_id
  sub_resource_id_connectivity = data.azurerm_subscriptions.connectivity.subscriptions[0].id
  sub_name_connectivity        = data.azurerm_subscriptions.connectivity.subscriptions[0].display_name

  group_roles = flatten([
    for k, v in var.group_roles : [
      for i in v : { member = k, role = i }
    ]
  ])
}

