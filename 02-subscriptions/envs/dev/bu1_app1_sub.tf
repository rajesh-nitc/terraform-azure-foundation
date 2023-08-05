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
  # Must pass app type key as [web/api]
  # web and api are external, web required auth with azure ad
  # Must use [web/api]-cicd for workflows or just [web/api] for actual apps 
  uai_roles = {

    # Infra
    "infra-cicd" = [
      "Contributor",
      "Storage Blob Data Contributor", # tfstate
      "Key Vault Secrets Officer",
    ]

    # web
    "web-cicd" = [
      "AcrPush",
      "Managed Identity Operator", # To be able to use uais. web-cicd will use uai web for the container
      "Key Vault Secrets User",
      "Contributor", # Until Azure provide container app admin role
    ]

    # app
    "web" = [
      "AcrPull",

    ]

    # api
    "api-cicd" = [
      "AcrPush",
      "Managed Identity Operator", # To be able to use uais. api-cicd will use uai api for the container
      "Key Vault Secrets User",
      "Contributor", # Until Azure provide container app admin role
    ]

    # app
    "api" = [
      "AcrPull",

    ]
  }

  # In real world, repos will be different
  # repos must exist before running this code
  # The keys must include cicd as suffix and must match with keys of uai_roles

  # If the key includes "cicd", uai will be federated for github openid auth:

  # If the key includes "cicd" but not "infra":
  # github secrets for acr name and rg name will be created

  # For web-cicd and api-cicd, their prefix will be used to create 
  # github secrets for their uai ids - which will be used by [web/api]-cicd workflow to assign it to a container app
  uai_repos = {
    "infra-cicd"  = "rajesh-nitc/terraform-azure-foundation"
    "web-cicd" = "rajesh-nitc/terraform-azure-foundation"
    "api-cicd"    = "rajesh-nitc/terraform-azure-foundation"
  }

  # Group will be created and role assignments are given to group at subscription level
  # Must have a key named azure-devs
  group_roles = {
    "azure-devs" = [
      "Contributor",
      "Key Vault Secrets Officer",
    ]
    "azure-admins" = [
      "Contributor",
      "Key Vault Secrets Officer",
    ]
  }

}

