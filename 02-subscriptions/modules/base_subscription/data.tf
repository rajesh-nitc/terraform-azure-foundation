data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {
}

data "azurerm_management_group" "mg" {
  display_name = format("mg-%s", var.env)
}

data "azuread_application_published_app_ids" "well_known" {
}
