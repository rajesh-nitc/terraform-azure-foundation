module "hub_vnet" {
  source = "../../modules/base_vnet"

  providers = {
    azurerm.connectivity = azurerm.sub-common-connectivity
  }

  env                = "hub"
  bu                 = ""
  app                = ""
  location           = "westus"
  vnet_address_space = ["10.0.0.0/18"]

  private_dns_zones = [
    "privatelink.azurecr.io",
    # "privatelink.vaultcore.azure.net",
    # "privatelink.blob.core.windows.net",
  ]

  # Firewall
  enable_firewall = false
  # firewall_address_prefixes = ["10.0.0.0/24"]

  # Bastion
  enable_bastion = false
  # bastion_address_prefixes = ["10.0.1.0/24"]

}


