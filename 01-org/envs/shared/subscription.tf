resource "azurerm_subscription" "management" {
  alias             = local.subscription_management_name
  subscription_name = local.subscription_management_name
  subscription_id   = local.subscription_management_id
  lifecycle {
    ignore_changes = [
      # we changed the subscription name on the portal
      # we might change it again if we find a better naming for subscription
      alias,
    ]
  }
}

resource "azurerm_management_group_subscription_association" "common_management" {
  management_group_id = azurerm_management_group.common.id
  subscription_id     = "/subscriptions/${local.subscription_management_id}"
}

resource "azurerm_subscription" "connectivity" {
  alias             = local.subscription_connectivity_name
  subscription_name = local.subscription_connectivity_name
  subscription_id   = local.subscription_connectivity_id
  lifecycle {
    ignore_changes = [
      # we changed the subscription name on the portal
      # we might change it again if we find a better naming for subscription
      alias,
    ]
  }
}

resource "azurerm_management_group_subscription_association" "common_connectivity" {
  management_group_id = azurerm_management_group.common.id
  subscription_id     = "/subscriptions/${local.subscription_connectivity_id}"
}

