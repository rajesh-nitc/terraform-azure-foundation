resource "azurerm_management_group" "common" {
  display_name               = format("mg-%s", var.shared_resource_naming)
  parent_management_group_id = data.azurerm_management_group.root.id
}
