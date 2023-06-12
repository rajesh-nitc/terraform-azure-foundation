terraform {
  backend "azurerm" {
    storage_account_name = "staorgtfstate"
    container_name       = "stc-org-tfstate"
    key                  = "org.tfstate"
    resource_group_name  = "rg-org-tfstate"
  }
}