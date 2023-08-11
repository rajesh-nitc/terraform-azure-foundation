resource "azurerm_subscription" "management" {
  alias             = local.sub_name_management
  subscription_name = local.sub_name_management
  subscription_id   = local.sub_id_management
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
  subscription_id     = local.sub_resource_id_management
}

resource "azurerm_subscription" "connectivity" {
  alias             = local.sub_name_connectivity
  subscription_name = local.sub_name_connectivity
  subscription_id   = local.sub_id_connectivity
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
  subscription_id     = local.sub_resource_id_connectivity
}

