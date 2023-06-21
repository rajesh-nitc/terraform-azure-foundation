locals {
  scope                          = data.azurerm_management_group.root.id
  subscriptions_all              = data.azurerm_subscriptions.all.subscriptions
  subscription_management_id     = data.azurerm_subscriptions.management.subscriptions[0].subscription_id
  subscription_management_name   = data.azurerm_subscriptions.management.subscriptions[0].display_name
  subscription_connectivity_id   = data.azurerm_subscriptions.connectivity.subscriptions[0].subscription_id
  subscription_connectivity_name = data.azurerm_subscriptions.connectivity.subscriptions[0].display_name
}

