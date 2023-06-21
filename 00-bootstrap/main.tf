locals {
  default_subscription_id   = data.azurerm_subscription.current.subscription_id
  default_subscription_name = data.azurerm_subscription.current.display_name
}

resource "azurerm_management_group" "root" {
  display_name = "mg-root"
}

resource "azurerm_management_group" "bootstrap" {
  display_name               = "mg-bootstrap"
  parent_management_group_id = azurerm_management_group.root.id

  subscription_ids = [
    # Assign sub-bootstrap-tfstate to mg-bootstrap
    local.default_subscription_id
  ]
}

# This is actually your first default subscription that you get with pay as you go
resource "azurerm_subscription" "tfstate" {
  alias             = local.default_subscription_name
  subscription_name = local.default_subscription_name
  subscription_id   = local.default_subscription_id
  lifecycle {
    ignore_changes = [
      # we changed the subscription name on the portal
      # we might change it again if we find a better naming for subscription
      alias,
    ]
  }
}

# We did not specify the subscription - the current subscription used by tf will be used
resource "azurerm_resource_group" "tfstate" {
  name     = module.naming.resource_group.name
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = module.naming.storage_account.name
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = module.naming.storage_container.name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}