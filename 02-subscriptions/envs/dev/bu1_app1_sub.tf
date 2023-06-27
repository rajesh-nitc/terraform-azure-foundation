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

  # uai will be created and roles will be assigned to uai on subscription
  uai_roles = {
    "infra-cicd" = ["Contributor"]
    "app-cicd"   = []
    "app"        = ["AcrPull"] # Should be on container registry but i guess no harm at sub level
  }

  # group will be created and roles will be assigned to group on subscription
  group_roles = {
    "azure-devs"   = ["Reader"]
    "azure-admins" = ["Contributor"]
  }
}