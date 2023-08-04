module "bu1_app1_aca_infra" {
  source = "../../modules/aca"

  env          = "dev"
  bu           = "bu1"
  app          = "app1"
  location     = "westus"
  deploy_appgw = false

}