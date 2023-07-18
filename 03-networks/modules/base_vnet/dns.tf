resource "azurerm_private_dns_zone" "dns" {
  for_each            = var.env == "hub" ? toset(var.private_dns_zones) : []
  name                = each.key
  resource_group_name = local.rg_name
}

# module naming does not support private_dns_zone_virtual_network_link
resource "azurerm_private_dns_zone_virtual_network_link" "hub_link" {
  for_each              = var.env == "hub" ? toset(var.private_dns_zones) : []
  name                  = format("%s-%s-%s-%s", "pnetlk", split(".", each.key)[1], var.location, var.env)
  resource_group_name   = local.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.dns[each.key].name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke_link" {
  for_each              = var.env != "hub" ? toset(var.private_dns_zones) : []
  name                  = format("%s-%s-%s-%s", "pnetlk", split(".", each.key)[1], var.bu, var.app, var.location, var.env)
  resource_group_name   = data.azurerm_private_dns_zone.dns[each.key].resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.dns[each.key].name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

