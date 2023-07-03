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
  # Must have a key named infra-cicd
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

  # In real world, repos will be different
  # The keys must match with the uai_roles
  # If the key provided by user contains "cicd", uai github integration will be created
  # For e.g. uai github integration will not be created for "app"
  uai_repos = {
    "infra-cicd" = "rajesh-nitc/terraform-azure-foundation"
    "app-cicd"   = "rajesh-nitc/terraform-azure-foundation"
    "app"        = "rajesh-nitc/terraform-azure-foundation"
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

