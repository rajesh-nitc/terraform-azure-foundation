module "bu1_app1_aca_infra" {
  source = "../../modules/aca"

  env          = "dev"
  bu           = "bu1"
  app          = "app1"
  location     = "westus"
  deploy_appgw = false

  apps = {
    webspa = {
      app_type    = "webspa"
      external    = true
      target_port = 3000
    }

    api = {
      app_type    = "api"
      external    = false
      target_port = 3500
    }
  }

}