resource "azurerm_management_group" "common" {
  display_name               = format("%s-%s", "mg", "common")
  parent_management_group_id = data.azurerm_management_group.root.id
}
