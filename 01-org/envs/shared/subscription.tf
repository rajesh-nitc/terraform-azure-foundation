resource "azurerm_management_group_subscription_association" "common_management" {
  management_group_id = azurerm_management_group.common.id
  subscription_id     = local.sub_resource_id_management
}

resource "azurerm_management_group_subscription_association" "common_connectivity" {
  management_group_id = azurerm_management_group.common.id
  subscription_id     = local.sub_resource_id_connectivity
}

