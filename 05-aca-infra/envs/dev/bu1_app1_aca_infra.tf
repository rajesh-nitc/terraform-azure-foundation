module "bu1_app1_aca_infra" {
  source = "../../modules/aca"
  # providers = {
  #   azurerm.connectivity = azurerm.sub-common-connectivity
  # }

  env      = "dev"
  bu       = "bu1"
  app      = "app1"
  location = "westus"

}
