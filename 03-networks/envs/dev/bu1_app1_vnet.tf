module "bu1_app1_vnet" {
  source = "../../modules/base_vnet"
  providers = {
    azurerm = azurerm.sub-bu1-app1-dev
  }
  env                = var.env
  location           = var.location
  bu                 = "bu1"
  app                = "app1"
  vnet_address_space = ["10.0.64.0/18"]

  # default subnets
  enable_appgwsubnet     = true
  appgw_address_prefixes = ["10.0.66.0/24"]
  pe_address_prefixes    = ["10.0.65.0/24"]

  private_dns_zones = [
    "privatelink.azurecr.io",
    "privatelink.vaultcore.azure.net",
    # "privatelink.blob.core.windows.net",
  ]

  snets = {
    app1subnet = {
      name             = "app1subnet"
      address_prefixes = ["10.0.64.0/24"]

      # route_table_name = "workload1"
      # routes = [
      #   {
      #     route_name             = "default-egress"
      #     address_prefix         = "0.0.0.0/0"
      #     next_hop_type          = "VirtualAppliance"
      #     next_hop_in_ip_address = "" # firewall
      #   }
      # ]
    },

  }
}
