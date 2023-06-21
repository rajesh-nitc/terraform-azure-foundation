resource "azurerm_subscription" "sub" {
  alias             = local.sub_name
  subscription_name = local.sub_name
  subscription_id   = local.sub_id
  lifecycle {
    ignore_changes = [
      # we might change the name on the portal if we find a better naming for subscription
      alias,
    ]
  }
}

resource "azurerm_management_group_subscription_association" "sub" {
  management_group_id = local.mg_id
  subscription_id     = local.id
}