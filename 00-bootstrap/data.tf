data "azurerm_subscription" "current" {
}

data "azuread_application_published_app_ids" "well_known" {
}

data "azuread_client_config" "current" {}

data "azurerm_management_group" "root" {
  name = data.azurerm_subscription.current.tenant_id
}

