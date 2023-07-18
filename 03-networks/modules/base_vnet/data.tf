data "azurerm_virtual_network" "hub_vnet" {
  provider            = azurerm.connectivity
  count               = var.env != "hub" ? 1 : 0
  name                = format("%s-%s-%s", "vnet", var.location, "hub")
  resource_group_name = format("%s-%s-%s-%s", "rg", var.location, "hub", "net")
}

data "azurerm_subnet" "bastion" {
  count                = length(var.bastion_address_prefixes) > 0 && var.env == "hub" ? 1 : 0
  name                 = "AzureBastionSubnet"
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rg_name

  depends_on = [
    azurerm_subnet.snet
  ]
}

data "azurerm_subnet" "firewall" {
  count                = length(var.firewall_address_prefixes) > 0 && var.env == "hub" ? 1 : 0
  name                 = "AzureFirewallSubnet"
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rg_name

  depends_on = [
    azurerm_subnet.snet
  ]
}

data "azurerm_container_registry" "acr" {
  count               = contains(var.private_dns_zones, "privatelink.azurecr.io") && var.env != "hub" ? 1 : 0
  name                = module.naming.container_registry.name
  resource_group_name = module.naming.resource_group.name
}

data "azurerm_key_vault" "kv" {
  count               = contains(var.private_dns_zones, "privatelink.vaultcore.azure.net") && var.env != "hub" ? 1 : 0
  name                = module.naming.key_vault.name
  resource_group_name = module.naming.resource_group.name
}

data "azurerm_private_dns_zone" "dns" {
  provider            = azurerm.connectivity
  for_each            = var.env != "hub" ? toset(var.private_dns_zones) : []
  name                = each.key
  resource_group_name = format("%s-%s-%s-%s", "rg", var.location, "hub", "net")
}