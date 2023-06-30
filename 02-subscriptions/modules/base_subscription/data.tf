data "azurerm_client_config" "current" {}

data "azurerm_management_group" "mg" {
  display_name = format("mg-%s", var.env)
}

data "azurerm_subscriptions" "all" {
  display_name_contains = format("%s-%s-%s", var.bu, var.app, var.env)
}
