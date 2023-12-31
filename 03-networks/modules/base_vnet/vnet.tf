resource "azurerm_virtual_network" "vnet" {
  name                = module.naming.virtual_network.name
  location            = var.location
  resource_group_name = local.rg_name
  address_space       = var.vnet_address_space
}

resource "azurerm_virtual_network_peering" "spoke-hub" {
  count                        = var.env != "hub" ? 1 : 0
  name                         = format("%s-%s-hub", module.naming.virtual_network_peering.name, var.env)
  resource_group_name          = local.rg_name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_vnet[count.index].id
  allow_virtual_network_access = true # yes please, we don't want to create nsg rules!
}

resource "azurerm_virtual_network_peering" "hub-spoke" {
  provider                     = azurerm.connectivity
  count                        = var.env != "hub" ? 1 : 0
  name                         = format("%s-hub-%s", module.naming.virtual_network_peering.name, var.env)
  resource_group_name          = format("%s-%s-%s-%s", "rg", var.location, "hub", "net")
  virtual_network_name         = data.azurerm_virtual_network.hub_vnet[count.index].name
  remote_virtual_network_id    = azurerm_virtual_network.vnet.id
  allow_virtual_network_access = true # yes please, we don't want to create nsg rules!
}