locals {
  default_subscription_id   = data.azurerm_subscription.current.subscription_id
  default_subscription_name = data.azurerm_subscription.current.display_name
}
