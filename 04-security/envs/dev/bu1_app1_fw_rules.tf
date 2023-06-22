module "fw_rules_bu1_app1_dev" {
  source = "../../modules/base_fw_rules"
  providers = {
    azurerm = azurerm.sub-common-connectivity
  }

  bu  = "bu1"
  app = "app1"

  env                 = var.env
  location            = var.location
  resource_group_name = var.resource_group_name
  firewall_name       = var.firewall_name
  firewall_public_ip  = var.firewall_public_ip

  network_rule_collections     = []
  application_rule_collections = []
  nat_rule_collections         = []

}
