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
  private_dns_zones = [
    "privatelink.azurecr.io",
    "privatelink.blob.core.windows.net",
    "privatelink.vaultcore.azure.net",

  ]

  snets = {
    app1subnet = {
      name              = "app1subnet"
      address_prefixes  = ["10.0.64.0/24"]
      service_endpoints = []

      private_endpoint_network_policies_enabled     = false
      private_link_service_network_policies_enabled = false

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

    pepsubnet = {
      name             = "pepsubnet"
      address_prefixes = ["10.0.65.0/24"]
      service_endpoints = [
        "Microsoft.ContainerRegistry",
        # "Microsoft.Storage",
        # "Microsoft.KeyVault",
      ]

      private_endpoint_network_policies_enabled     = true
      private_link_service_network_policies_enabled = false
    },
  }
}
