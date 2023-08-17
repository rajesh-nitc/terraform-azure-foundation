data "azuread_client_config" "current" {}

data "azurerm_management_group" "root" {
  display_name = format("%s-root", "mg")
}
