data "azurerm_subscription" "current" {
}

resource "azurerm_management_group" "bootstrap" {
  display_name = "mg-bootstrap"

  subscription_ids = [
    data.azurerm_subscription.current.subscription_id
  ]
}

resource "azurerm_subscription" "tfstate" {
  alias             = "bootstrap-tfstate"
  subscription_name = "bootstrap-tfstate"
  subscription_id   = data.azurerm_subscription.current.subscription_id
} 