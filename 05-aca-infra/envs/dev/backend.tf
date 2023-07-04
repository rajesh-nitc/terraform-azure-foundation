terraform {
  backend "azurerm" {
    use_oidc             = true
    storage_account_name = "storgtfstate"
    container_name       = "stct-org-tfstate"
    key                  = "dev-bu1-app1-aca-infra.tfstate"
    resource_group_name  = "rg-org-tfstate"
  }
}