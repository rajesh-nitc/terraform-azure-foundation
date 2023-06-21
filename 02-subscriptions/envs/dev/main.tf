module "bu1_app1_dev_sub" {
  source = "../../modules/base_subscription"
  providers = {
    azurerm = azurerm.sub-bu1-app1-dev
  }

  env      = "dev"
  bu       = "bu1"
  app      = "app1"
  location = "westus"

  # uai will be created and the roles will be assigned to uai on subscription
  uai_roles = {
    "infra-cicd" = ["Contributor"]
    "app-cicd"   = ["Contributor"]
    "workload"   = ["Storage Blob Data Reader"]
  }

  # group will be created and the roles will be assigned to group on subscription
  group_roles = {
    "viewer" = ["Reader"]
    "devs"   = ["Contributor"]
  }
}