module "bu1_app1_sub" {
  source = "../../modules/base_subscription"
  providers = {
    azurerm = azurerm.sub-bu1-app1-dev
  }

  env      = "dev"
  bu       = "bu1"
  app      = "app1"
  location = "westus"

  enable_kv = false

  # Role assignments are at subscription level
  # Must have a key named infra-cicd
  uai_roles = {
    "infra-cicd" = [
      "Contributor",
      "Storage Blob Data Contributor", # tfstate
    ]
    "app-backend-cicd" = [
      "AcrPush",
      "Managed Identity Operator", # To be able to use uais. App backend cicd will use uai app-backend
    ]
    "app-backend" = [
      "AcrPull",
      "Key Vault Secrets User",
    ]
  }

  # In real world, repos will be different
  # The keys must match with the keys in uai_roles

  # If the key includes "cicd", uai github openid connect integration will be created:
  # For e.g. uai github openid connect integration will not be created for "app-backend"

  # If the key includes "cicd" but not "infra":
  # acr will be created along with github secrets for acr name and rg name

  # If the key includes "app" but not "cicd" and "infa":
  # github secret for app uai id will be created
  uai_repos = {
    "infra-cicd"       = "rajesh-nitc/terraform-azure-foundation"
    "app-backend-cicd" = "rajesh-nitc/terraform-azure-foundation"
    "app-backend"      = "rajesh-nitc/terraform-azure-foundation"
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

}

