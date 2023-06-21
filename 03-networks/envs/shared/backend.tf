terraform {
  backend "azurerm" {
    storage_account_name = "storgtfstate"
    container_name       = "stct-org-tfstate"
    key                  = "shared-network.tfstate"
    resource_group_name  = "rg-org-tfstate"
  }
}