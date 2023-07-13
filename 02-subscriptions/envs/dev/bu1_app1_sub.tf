module "bu1_app1_sub" {
  source = "../../modules/base_subscription"
  providers = {
    azurerm = azurerm.sub-bu1-app1-dev
  }

  env      = "dev"
  bu       = "bu1"
  app      = "app1"
  location = "westus"

  # Uai will be created and role assignments are given to uai at subscription level
  # Must have a key named infra-cicd
  # App type is [web-e-auth/web-e]
  # e stands for external
  # web-e-auth require auth with azure ad
  # web-e is open to all users
  # Must use [web-e-auth/web-e]-cicd for workflows or just [web-e-auth/web-e] for actual apps 
  uai_roles = {
    "infra-cicd" = [
      "Contributor",
      "Storage Blob Data Contributor", # tfstate
      "Key Vault Secrets Officer",
    ]
    "web-e-auth-cicd" = [
      "AcrPush",
      "Managed Identity Operator", # To be able to use uais. web-e-auth-cicd will use uai web-e-auth for the container
      "Key Vault Secrets User",
      "Contributor", # Until Azure provide container app admin role
    ]
    "web-e-auth" = [
      "AcrPull",

    ]
  }

  # In real world, repos will be different
  # The keys must match with the keys in uai_roles

  # If the key includes "cicd", uai will be federated for github openid auth:
  # For e.g. uai web-e-auth will not be federated because it's not used by workflow. It will be used by the actual app.

  # If the key includes "cicd" but not "infra":
  # acr will be created along with github secrets for acr name and rg name

  # If the key does not include "cicd" and "infa":
  # github secret for [web-e-auth/web-e] uai ID will be created - which will be used by [web-e-auth/web-e]-cicd workflow to assign it to a container app
  uai_repos = {
    "infra-cicd"      = "rajesh-nitc/terraform-azure-foundation"
    "web-e-auth-cicd" = "rajesh-nitc/terraform-azure-foundation"
    "web-e-auth"      = "rajesh-nitc/terraform-azure-foundation"
  }

  # Group will be created and role assignments are given to group at subscription level
  # Must have a key named azure-devs
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

