module "fw_rules_bu1_app1_dev" {
  source = "../../modules/base_fw_rules"
  providers = {
    azurerm = azurerm.sub-common-connectivity
  }

  env                 = "dev"
  bu                  = "bu1"
  app                 = "app1"
  location            = "westus"
  resource_group_name = "rg-hub"
  firewall_name       = "test-firewall"
  firewall_public_ip  = ""

}
