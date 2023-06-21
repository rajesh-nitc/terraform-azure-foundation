module "fw_rules_hub" {
  source = "../../modules/base_fw_rules"
  providers = {
    azurerm = azurerm.sub-common-connectivity
  }

  env = var.env

  resource_group_name          = var.resource_group_name
  location                     = var.location
  firewall_name                = var.firewall_name
  firewall_public_ip           = var.firewall_public_ip
  network_rule_collections     = var.network_rule_collections
  application_rule_collections = var.application_rule_collections
  nat_rule_collections         = var.nat_rule_collections
}
