module "hub_vnet" {
  source = "../../modules/base_vnet"
  providers = {
    azurerm = azurerm.sub-common-connectivity
  }
  env                = var.env
  bu                 = var.bu
  app                = var.app
  location           = var.location
  vnet_address_space = var.vnet_address_space
  snets              = var.snets
  private_dns_zones  = var.private_dns_zones

  # Firewall
  enable_firewall           = var.enable_firewall
  firewall_address_prefixes = var.firewall_address_prefixes

  # Bastion
  enable_bastion           = var.enable_bastion
  bastion_address_prefixes = var.bastion_address_prefixes

  # Nat
  enable_nat = var.enable_nat

}


