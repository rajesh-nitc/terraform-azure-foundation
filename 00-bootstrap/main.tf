resource "azurerm_management_group" "root" {
  display_name = "mg-root"
}

resource "azurerm_management_group" "bootstrap" {
  display_name               = "mg-bootstrap"
  parent_management_group_id = azurerm_management_group.root.id

  subscription_ids = [
    # Assign bootstrap-tfstate subscription to mg-bootstrap
    data.azurerm_subscription.current.subscription_id
  ]
}

# This is actually the default subscription that you get with pay as you go
# We are just changing its name from pay as you go to bootstrap-tfstate
resource "azurerm_subscription" "tfstate" {
  alias             = "bootstrap-tfstate"
  subscription_name = "bootstrap-tfstate"
  subscription_id   = data.azurerm_subscription.current.subscription_id
}

# We did not specify the subscription - the current subscription used by tf will be used
resource "azurerm_resource_group" "tfstate" {
  name     = "rg-org-tfstate"
  location = "West Europe"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "staorgtfstate"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "stc-org-tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}