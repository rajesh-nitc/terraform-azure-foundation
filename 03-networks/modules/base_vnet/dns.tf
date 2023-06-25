resource "azurerm_private_dns_zone" "dns" {
  for_each            = toset(var.private_dns_zones)
  name                = format("%s-%s", module.naming.private_dns_zone.name, each.key)
  resource_group_name = local.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each              = toset(var.private_dns_zones)
  name                  = format("%s-%s", azurerm_private_dns_zone.dns[each.key].name, "link")
  resource_group_name   = local.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.dns[each.key].name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}