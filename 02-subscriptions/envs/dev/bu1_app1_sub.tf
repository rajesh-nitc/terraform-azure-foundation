module "bu1_app1_sub" {
  source = "../../modules/base_subscription"
  providers = {
    azurerm = azurerm.sub-bu1-app1-dev
  }

  env      = "dev"
  bu       = "bu1"
  app      = "app1"
  location = "westus"

  enable_acr = false
  enable_kv  = false

  # Role assignments are at subscription level
  # "infra-cicd" and "app-cicd" are standard keys
  # There is a validation that require uai_roles must have :
  # key named "infra-cicd" and a key named "app-cicd" and a key named "app"
  # To enforce every subscription has a uai for infra cicd and app cicd and app
  uai_roles = {
    "infra-cicd" = [
      "Contributor",
      "Managed Identity Operator",     # To be able to use uais
      "Storage Blob Data Contributor", # tfstate
    ]
    "app-cicd" = [
      "AcrPush",
    ]
    "app" = [
      "AcrPull",
      "Key Vault Secrets User",
    ]
  }

  group_roles = {
    "azure-devs" = [
      "Reader",
      "Key Vault Secrets Officer",
    ]
    "azure-admins" = [
      "Contributor",
      "Key Vault Secrets Officer",
    ]
  }

  # Github
  gh_owner = "rajesh-nitc"
  gh_repo  = "terraform-azure-foundation"
}

