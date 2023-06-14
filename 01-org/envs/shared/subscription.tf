# Bought new pay as you go subscription. Let's change its name
resource "azurerm_subscription" "management" {
  alias             = "common-management"
  subscription_name = "common-management"
  subscription_id   = var.management_subscription_id
}

resource "azurerm_management_group_subscription_association" "common_management" {
  management_group_id = azurerm_management_group.mg["mg-common"].id
  subscription_id     = "/subscriptions/${var.management_subscription_id}"
}

