locals {

  all_snets = merge(
    var.enable_bastion && var.env == "hub"
    ? local.bastion_snet
    : {},
    var.enable_firewall && var.env == "hub"
    ? local.firewall_snet
    : {},
    var.snets
  )

  bastion_snet = {

    AzureBastionSubnet = {
      name              = "AzureBastionSubnet"
      address_prefixes  = var.bastion_address_prefixes
      service_endpoints = []

      private_endpoint_network_policies_enabled     = false
      private_link_service_network_policies_enabled = false

      nsg_name = "bastion"
      nsg_rules = {
        "bastionAllowHTTPSInbound" = {
          name                       = "bastionAllowHTTPSInbound"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["443"]
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        }
        "bastionAllowGatewayManagerInbound" = {
          name                       = "bastionAllowGatewayManagerInbound"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["443"]
          source_address_prefix      = "GatewayManager"
          destination_address_prefix = "*"
        }
        "bastionAllowAzureLBInbound" = {
          name                       = "AllowAzureLBInbound"
          priority                   = 300
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["443"]
          source_address_prefix      = "AzureLoadBalancer"
          destination_address_prefix = "*"
        }
        "bastionAllowBastionHostCommunication" = {
          name                       = "AllowBastionHostCommunication"
          priority                   = 400
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["5701", "8080"]
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "VirtualNetwork"
        }
        "bastionAllowRdpSshOutbound" = {
          name                       = "AllowRdpSshOutbound"
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["22", "3389"]
          source_address_prefix      = "*"
          destination_address_prefix = "VirtualNetwork"
        }
        "bastionAllowBastionHostCommunicationOutbound" = {
          name                       = "AllowBastionHostCommunicationOutbound"
          priority                   = 110
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["5701", "8080"]
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "VirtualNetwork"
        }
        "bastionAllowAzureCloudOutbound" = {
          name                       = "AllowAzureCloudOutbound"
          priority                   = 120
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["443"]
          source_address_prefix      = "*"
          destination_address_prefix = "AzureCloud"
        }
        "bastionAllowGetSessionInformation" = {
          name                       = "AllowGetSessionInformation"
          priority                   = 130
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_ranges         = ["*"]
          destination_port_ranges    = ["80"]
          source_address_prefix      = "*"
          destination_address_prefix = "Internet"
        }

      }
      # ROUTES
      # do we route bastion traffic through firewall ?
      # https://learn.microsoft.com/en-us/azure/bastion/bastion-faq#udr
      # For scenarios that include both Azure Bastion and Azure Firewall/Network Virtual Appliance (NVA) 
      # in the same virtual network, you don’t need to force traffic from an Azure Bastion subnet to 
      # Azure Firewall because the communication between Azure Bastion and your VMs is private

    },

  }

  firewall_snet = {

    AzureFirewallSubnet = {
      name              = "AzureFirewallSubnet"
      address_prefixes  = var.firewall_address_prefixes
      service_endpoints = []

      private_endpoint_network_policies_enabled     = false
      private_link_service_network_policies_enabled = false

      # NSG
      # do we need nsg rule to allow outbound internet traffic on AzureFirewallSubnet ?
      # https://learn.microsoft.com/en-us/azure/firewall/firewall-faq#are-network-security-groups--nsgs--supported-on-the-azurefirewallsubnet
      # Azure Firewall is a managed service with multiple protection layers, including 
      # platform protection with NIC level NSGs (not viewable). Subnet level NSGs aren't 
      # required on the AzureFirewallSubnet, and are disabled to ensure no service interruption.

      # ROUTES
      # do we need default route to Internet on AzureFirewallSubnet ?
      # Answer seems to be NO as the scenario in the link below seems to work
      # https://learn.microsoft.com/en-us/azure/firewall/tutorial-firewall-deploy-portal

    }
  }

  nsg_rules = flatten([
    for i in values(local.all_snets) : [
      for k, v in coalesce(try(i.nsg_rules, null), {}) : {
        nsg_name                   = i.nsg_name
        name                       = v.name
        priority                   = v.priority
        direction                  = v.direction
        access                     = v.access
        protocol                   = v.protocol
        source_port_ranges         = v.source_port_ranges
        destination_port_ranges    = v.destination_port_ranges
        source_address_prefix      = v.source_address_prefix
        destination_address_prefix = v.destination_address_prefix
      }

    ]
  ])

  routes = flatten([
    for i in values(local.all_snets) : [
      for j in coalesce(try(i.routes, null), []) : {
        route_table_name       = i.route_table_name
        route_name             = j.route_name
        address_prefix         = j.address_prefix
        next_hop_type          = j.next_hop_type
        next_hop_in_ip_address = j.next_hop_in_ip_address
      }

    ]
  ])

}
