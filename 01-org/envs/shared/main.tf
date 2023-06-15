locals {
  scope                          = data.azurerm_management_group.root.id
  subscription_management_id     = data.azurerm_subscriptions.management.subscriptions[0].subscription_id
  subscription_management_name   = format("%s-%s", var.shared_resource_naming, var.subscription_management_suffix)
  subscriptions_all              = data.azurerm_subscriptions.all.subscriptions
  subscription_connectivity_id   = data.azurerm_subscriptions.connectivity.subscriptions[0].subscription_id
  subscription_connectivity_name = format("%s-%s", var.shared_resource_naming, var.subscription_connectivity_suffix)
}