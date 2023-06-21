resource "azurerm_network_security_group" "nsg" {
  for_each            = { for i in var.snets : i.nsg_name => i if i.nsg_name != null }
  name                = format("%s-%s", module.naming.network_security_group.name, each.value.name)
  resource_group_name = local.rg_name
  location            = var.location
}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each                    = { for i in local.nsg_rules : "${i.nsg_name}-${i.name}" => i }
  name                        = format("%s-%s", module.naming.network_security_rule.name, each.value.name)
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_ranges          = each.value.source_port_ranges
  destination_port_ranges     = each.value.destination_port_ranges
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = local.rg_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.nsg_name].name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each                  = { for i in var.snets : i.name => i if i.nsg_name != null }
  subnet_id                 = azurerm_subnet.snet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg_name].id
}

# do we need nsg rule to allow outbound internet traffic on AzureFirewallSubnet ?
# https://learn.microsoft.com/en-us/azure/firewall/firewall-faq#are-network-security-groups--nsgs--supported-on-the-azurefirewallsubnet
# Azure Firewall is a managed service with multiple protection layers, including 
# platform protection with NIC level NSGs (not viewable). Subnet level NSGs aren't 
# required on the AzureFirewallSubnet, and are disabled to ensure no service interruption.
