terraform {
  backend "azurerm" {
    use_oidc             = true
    storage_account_name = "stbu1app1devwestustf"
    container_name       = "stct-bu1-app1-dev-westus-tf"
    key                  = "dev-bu1-app1-aca-infra.tfstate"
    resource_group_name  = "rg-bu1-app1-dev-westus-tf"

    # we have been using sp-org-terraform until now with the stct in sub-bootstrap-tfstate
    # stct above is in sub-bu1-app1-dev subscription
    # Need to include sub-bu1-app1-dev sub id if we want to run terraform locally with sp-org-terraform
    # For github workflow with use_oidc = true, it's not required

    subscription_id = "1b668524-37b9-410f-aede-fca0b2f2ee06"

  }


}