terraform {
  backend "azurerm" {
    storage_account_name = "storgtfstate"
    container_name       = "stct-org-tfstate"
    key                  = "bootstrap.tfstate"
    resource_group_name  = "rg-org-tfstate"
    use_azuread_auth     = true

  }
}