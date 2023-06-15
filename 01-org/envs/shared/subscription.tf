# Bought new pay as you go subscription. Let's change its name
resource "azurerm_subscription" "management" {
  alias             = local.subscription_management_name
  subscription_name = local.subscription_management_name
  subscription_id   = local.subscription_management_id
}

resource "azurerm_management_group_subscription_association" "common_management" {
  management_group_id = azurerm_management_group.common.id
  subscription_id     = "/subscriptions/${local.subscription_management_id}"
}

