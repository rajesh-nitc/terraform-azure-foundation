resource "azurerm_management_group" "mg" {
  for_each                   = toset(var.mgs)
  display_name               = each.value
  parent_management_group_id = data.azurerm_management_group.root.id
}