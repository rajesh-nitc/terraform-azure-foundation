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

  # uai will be created and roles will be assigned to uai on subscription
  uai_roles = {
    "infra-cicd" = ["Contributor", "Managed Identity Operator"]
    "app-cicd"   = ["AcrPush"]
    "app"        = ["AcrPull", "Key Vault Secrets User"]
  }

  # group will be created and roles will be assigned to group on subscription
  group_roles = {
    "azure-devs"   = ["Reader", "Key Vault Secrets Officer"]
    "azure-admins" = ["Contributor", "Key Vault Secrets Officer"]
  }
}