resource "azurerm_management_group" "common" {
  display_name               = format("%s-%s", "mg", "common")
  parent_management_group_id = local.scope
}

resource "azurerm_management_group" "dev" {
  display_name               = format("%s-%s", "mg", "dev")
  parent_management_group_id = local.scope
}