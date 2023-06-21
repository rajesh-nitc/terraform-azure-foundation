resource "azurerm_route_table" "route_table" {
  for_each                      = { for i in var.snets : i.route_table_name => i if i.route_table_name != null }
  name                          = format("%s-%s", module.naming.route_table.name, each.value.name)
  resource_group_name           = local.rg_name
  location                      = var.location
  disable_bgp_route_propagation = var.env != "hub" ? false : true
}

resource "azurerm_route" "route" {
  for_each            = { for i in local.routes : i.route_table_name => i if i.route_table_name != null }
  name                = format("%s-%s", module.naming.route_table.name, each.value.route_name)
  resource_group_name = local.rg_name
  route_table_name    = azurerm_route_table.route_table[each.key].name
  address_prefix      = each.value.address_prefix
  next_hop_type       = each.value.next_hop_type
  next_hop_in_ip_address = (
    each.value.next_hop_type == "VirtualAppliance"
    ? each.value.next_hop_in_ip_address
    : null
  )
}

resource "azurerm_subnet_route_table_association" "rt_association" {
  for_each       = { for i in var.snets : i.name => i if i.route_table_name != null }
  subnet_id      = azurerm_subnet.snet[each.key].id
  route_table_id = azurerm_route_table.route_table[each.value.route_table_name].id
}

# do we route bastion traffic through firewall ?
# https://learn.microsoft.com/en-us/azure/bastion/bastion-faq#udr
# For scenarios that include both Azure Bastion and Azure Firewall/Network Virtual Appliance (NVA) 
# in the same virtual network, you don’t need to force traffic from an Azure Bastion subnet to 
# Azure Firewall because the communication between Azure Bastion and your VMs is private

# do we need route for outbound traffic through nat if nat is enabled ?
# https://learn.microsoft.com/en-us/azure/nat-gateway/nat-gateway-resource#connect-to-the-internet-with-nat-gateway
# No routing configurations are required to start connecting outbound with NAT gateway. 
# NAT gateway becomes the default route to the internet after association to a subnet.

# do we need default route to Internet on AzureFirewallSubnet ?
# Answer seems to be NO as the scenario in the link below seems to work
# https://learn.microsoft.com/en-us/azure/firewall/tutorial-firewall-deploy-portal

# default route with next hop to Azure Firewall is definitely required in spokes
# users of this module will be passing the default egress route details