terraform {
  backend "azurerm" {
    use_oidc             = true
    storage_account_name = "stbu1app1devwestustf"
    container_name       = "stct-bu1-app1-dev-westus-tf"
    key                  = "dev-bu1-app1-aca-infra.tfstate"
    resource_group_name  = "rg-bu1-app1-dev-westus-tf"
  }
}