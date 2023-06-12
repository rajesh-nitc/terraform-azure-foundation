data "azurerm_subscription" "current" {
}

data "azurerm_management_group" "root" {
  display_name = var.mg_root_display_name
}