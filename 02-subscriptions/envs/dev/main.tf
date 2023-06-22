module "bu1_app1_dev_sub" {
  source = "../../modules/base_subscription"
  providers = {
    azurerm = azurerm.sub-bu1-app1-dev
  }

  env      = "dev"
  bu       = "bu1"
  app      = "app1"
  location = "westus"

  # uai will be created and roles will be assigned to uai on subscription
  uai_roles = {
    "infra-cicd" = ["Contributor"]
    "app-cicd"   = []
  }

  # group will be created and roles will be assigned to group on subscription
  group_roles = {
    "viewer" = ["Reader"]
    "devs"   = ["Reader"]
    "admins" = ["Contributor"]
  }
}