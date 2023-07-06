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
  # App Frontend: app-f
  # App Backend: app-b
  uai_roles = {
    "infra-cicd" = [
      "Contributor",
      "Storage Blob Data Contributor", # tfstate
      "Key Vault Secrets Officer",
    ]
    "app-b-cicd" = [
      "AcrPush",
      "Managed Identity Operator", # To be able to use uais. App backend cicd will use uai app-backend
      "Key Vault Secrets User",
      "Contributor", # Until we have a container app admin role from Azure
    ]
    "app-b" = [
      "AcrPull",

    ]
  }

  # In real world, repos will be different
  # The keys must match with the keys in uai_roles

  # If the key includes "cicd", uai will be fedearted for github openid auth:
  # For e.g. uai app-backend will not be federated

  # If the key includes "cicd" but not "infra":
  # acr will be created along with github secrets for acr name and rg name

  # If the key includes "app" but not "cicd" and "infa":
  # github secret for app uai ID will be created
  uai_repos = {
    "infra-cicd" = "rajesh-nitc/terraform-azure-foundation"
    "app-b-cicd" = "rajesh-nitc/terraform-azure-foundation"
    "app-b"      = "rajesh-nitc/terraform-azure-foundation"
  }

  # Group will be created and role assignments are given to group at subscription level
  group_roles = {
    "azure-devs" = [
      "Reader",
    ]
    "azure-admins" = [
      "Contributor",
      "Key Vault Secrets Officer",
    ]
  }

}

