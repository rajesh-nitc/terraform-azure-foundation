resource "azurerm_management_group" "root" {
  display_name = "mg-root"
}

resource "azurerm_management_group" "bootstrap" {
  display_name               = "mg-bootstrap"
  parent_management_group_id = azurerm_management_group.root.id

  subscription_ids = [
    # Assign sub-bootstrap-tfstate to mg-bootstrap
    var.default_subscription_id
  ]
}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-org-tfstate"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                      = "storgtfstate"
  resource_group_name       = azurerm_resource_group.tfstate.name
  location                  = azurerm_resource_group.tfstate.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  shared_access_key_enabled = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "stct-org-tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}