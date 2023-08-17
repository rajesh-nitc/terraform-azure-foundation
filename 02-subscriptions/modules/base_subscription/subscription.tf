resource "azurerm_management_group_subscription_association" "sub" {
  management_group_id = local.mg_id
  subscription_id     = local.sub_resource_id
}