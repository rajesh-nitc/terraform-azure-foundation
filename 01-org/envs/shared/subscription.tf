resource "azurerm_subscription" "management" {
  alias             = local.subscription_management_name
  subscription_name = local.subscription_management_name
  subscription_id   = local.subscription_management_id
}

resource "azurerm_management_group_subscription_association" "common_management" {
  management_group_id = azurerm_management_group.common.id
  subscription_id     = "/subscriptions/${local.subscription_management_id}"
}

resource "azurerm_subscription" "connectivity" {
  alias             = local.subscription_connectivity_name
  subscription_name = local.subscription_connectivity_name
  subscription_id   = local.subscription_connectivity_id
}

resource "azurerm_management_group_subscription_association" "common_connectivity" {
  management_group_id = azurerm_management_group.common.id
  subscription_id     = "/subscriptions/${local.subscription_connectivity_id}"
}

