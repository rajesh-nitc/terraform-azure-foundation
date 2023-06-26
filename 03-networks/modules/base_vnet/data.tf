# data "azurerm_virtual_network" "hub_vnet" {
#   count               = var.env != "hub" ? 1 : 0
#   name                = format("%s-hub-%s", "vnet", var.location)
#   resource_group_name = format("%s-hub-%s", "rg", var.location)
# }

data "azurerm_subnet" "bastion" {
  count                = var.enable_bastion && var.env == "hub" ? 1 : 0
  name                 = "AzureBastionSubnet"
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rg_name

  depends_on = [
    azurerm_subnet.snet
  ]
}

data "azurerm_subnet" "firewall" {
  count                = var.enable_firewall && var.env == "hub" ? 1 : 0
  name                 = "AzureFirewallSubnet"
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rg_name

  depends_on = [
    azurerm_subnet.snet
  ]
}