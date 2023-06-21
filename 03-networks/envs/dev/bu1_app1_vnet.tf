# we are creating a subnet "workload1" in which we will create a private linux vm
# we should be able to ssh into this vm from bastion
# we should be able to talk to storage service using az cli from within vm - to test service endpoint
# the outbound traffic to 0.0.0.0/0 from this vm should go through firewall
# we will create the application rules, network rules and nat rules in the next stage:
# so that this vm can talk to www.google.com

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

  snets = {
    workload1 = {
      name              = "workload1"
      address_prefixes  = ["10.0.64.0/24"]
      service_endpoints = ["Microsoft.Storage"] # Need to test it from within the vm using az cli

      private_endpoint_network_policies_enabled     = false
      private_link_service_network_policies_enabled = false

      nsg_name = "workload1"
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
        # do we need nsg rule for outbound traffic to firewall ?
        # nsg rule may not be required as default outbound rule to internet is there
      }

      route_table_name = "workload1"
      routes = [
        {
          route_name             = "default-egress"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.0.0.5" # firewall

        }

      ]
    },
  }



}
