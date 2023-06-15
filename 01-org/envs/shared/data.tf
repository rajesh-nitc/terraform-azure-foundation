data "azurerm_subscription" "current" {
}

data "azurerm_management_group" "root" {
  display_name = var.mg_root_display_name
}

data "azurerm_subscriptions" "all" {

}

data "azurerm_subscriptions" "management" {
  display_name_contains = var.subscription_management_suffix
}

data "azurerm_subscriptions" "connectivity" {
  display_name_contains = var.subscription_connectivity_suffix
}
