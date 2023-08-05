module "bu1_app1_vnet" {
  source = "../../modules/base_vnet"

  providers = {
    azurerm.connectivity = azurerm.sub-common-connectivity
  }

  env                = "dev"
  location           = "westus"
  bu                 = "bu1"
  app                = "app1"
  vnet_address_space = ["10.0.64.0/18"]

  private_dns_zones = [
    # "privatelink.azurecr.io",
    # "privatelink.vaultcore.azure.net",
    # "privatelink.blob.core.windows.net",
  ]

  # default subnets
  appgw_address_prefixes = []
  pe_address_prefixes    = ["10.0.66.0/24"]

  snets = {
    infrasubnet = {
      name             = "infrasubnet"
      address_prefixes = ["10.0.64.0/23"] # /23 is the minimum subnet size required
      enable_nat       = false

      # route_table_name = "default-egress"
      # routes = [
      #   {
      #     route_name             = "default-egress"
      #     address_prefix         = "0.0.0.0/0"
      #     next_hop_type          = "VirtualAppliance"
      #     next_hop_in_ip_address = "" # firewall
      #   }
      # ]

      # nsg_name = "infra"
      # nsg_rules = {

      #   "infra_Allow_Internal_AKS_UDP" = {
      #     name                       = "Allow_Internal_AKS_UDP",
      #     description                = "internal AKS secure connection between underlying nodes and control plane..",
      #     protocol                   = "Udp",
      #     source_address_prefix      = "VirtualNetwork",
      #     source_port_range          = "*",
      #     destination_address_prefix = "AzureCloud.westus",
      #     destination_port_ranges    = ["1194"],
      #     access                     = "Allow",
      #     priority                   = 100,
      #     direction                  = "Outbound"
      #   },
      #   "infra_Allow_Internal_AKS_TCP" = {
      #     name                       = "Allow_Internal_AKS_TCP",
      #     description                = "internal AKS secure connection between underlying nodes and control plane..",
      #     protocol                   = "Tcp",
      #     source_address_prefix      = "VirtualNetwork",
      #     source_port_range          = "*",
      #     destination_address_prefix = "AzureCloud.westus",
      #     destination_port_ranges    = ["9000"],
      #     access                     = "Allow",
      #     priority                   = 110,
      #     direction                  = "Outbound"
      #   },
      #   "infra_Allow_Azure_Monitor" = {
      #     name                       = "Allow_Azure_Monitor",
      #     description                = "Allows outbound calls to Azure Monitor.",
      #     protocol                   = "Tcp",
      #     source_address_prefix      = "VirtualNetwork",
      #     source_port_range          = "*",
      #     destination_address_prefix = "AzureCloud.westus",
      #     destination_port_ranges    = ["443"],
      #     access                     = "Allow",
      #     priority                   = 120,
      #     direction                  = "Outbound"
      #   },
      #   "infra_Allow_Outbound_443" = {
      #     name                       = "Allow_Outbound_443",
      #     description                = "Allowing all outbound on port 443 provides a way to allow all FQDN based outbound dependencies that don't have a static IP",
      #     protocol                   = "Tcp",
      #     source_address_prefix      = "VirtualNetwork",
      #     source_port_range          = "*",
      #     destination_address_prefix = "*",
      #     destination_port_ranges    = ["443"],
      #     access                     = "Allow",
      #     priority                   = 130,
      #     direction                  = "Outbound"
      #   },
      #   "infra_Allow_NTP_Server" = {
      #     name                       = "Allow_NTP_Server",
      #     description                = "NTP server",
      #     protocol                   = "Udp",
      #     source_address_prefix      = "VirtualNetwork",
      #     source_port_range          = "*",
      #     destination_address_prefix = "*",
      #     destination_port_ranges    = ["123"],
      #     access                     = "Allow",
      #     priority                   = 140,
      #     direction                  = "Outbound"
      #   },
      #   "infra_Allow_Container_Apps_control_plane" = {
      #     name                       = "Allow_Container_Apps_control_plane",
      #     description                = "Container Apps control plane",
      #     protocol                   = "Tcp",
      #     source_address_prefix      = "VirtualNetwork",
      #     source_port_range          = "*",
      #     destination_address_prefix = "*",
      #     destination_port_ranges    = ["5671", "5672"],
      #     access                     = "Allow",
      #     priority                   = 150,
      #     direction                  = "Outbound"
      #   }
      # }
    },

  }
}
