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

      nsg_name = "app1"
      nsg_rules = {
        "allow-bastion" = {
          name                       = "allow-bastion"
          priority                   = "100"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["22"]
          source_address_prefix      = "AzureBastionSubnet"
          destination_address_prefix = "*"
        },
        "allow-pe" = {
          name                       = "allow-pe"
          priority                   = "200"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["443"]
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "*"
        },

      }

      # route_table_name = "workload1"
      # routes = [
      #   {
      #     route_name             = "default-egress"
      #     address_prefix         = "0.0.0.0/0"
      #     next_hop_type          = "VirtualAppliance"
      #     next_hop_in_ip_address = "10.0.0.5" # firewall

      #   }

      # ]
    },

    pesubnet = {
      name             = "pesubnet"
      address_prefixes = ["10.0.65.0/24"]
      service_endpoints = [
        "Microsoft.ContainerRegistry",
        # "Microsoft.Storage",
        # "Microsoft.KeyVault",
      ]

      private_endpoint_network_policies_enabled     = true
      private_link_service_network_policies_enabled = false

      nsg_name = "pe"
      nsg_rules = {
        "allow-pe" = {
          name                       = "allow-pe"
          priority                   = "100"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["443"]
          source_address_prefix      = "10.0.64.0/24"
          destination_address_prefix = "*"
        },

      }

    },
  }



}
