data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {
}

data "azurerm_management_group" "root" {
  display_name = format("%s-root", "mg")
}

data "azurerm_subscriptions" "all" {

}

data "azurerm_subscriptions" "management" {
  display_name_contains = var.subscription_management_suffix
}

data "azurerm_subscriptions" "connectivity" {
  display_name_contains = var.subscription_connectivity_suffix
}

output "pp" {
  value       = data.azuread_client_config.current
  sensitive   = false
  description = "description"
  depends_on  = []
}
