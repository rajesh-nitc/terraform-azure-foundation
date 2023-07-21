# dns A records for acrbu1app1westusdev and acrbu1app1westusdev.westus.data
# will be created automatically by this resource
resource "azurerm_private_endpoint" "acr" {
  count               = contains(var.private_dns_zones, "privatelink.azurecr.io") && var.env != "hub" ? 1 : 0
  name                = format("%s-%s", module.naming.private_endpoint.name, "acr")
  location            = var.location
  resource_group_name = local.rg_name
  subnet_id           = azurerm_subnet.snet["pesubnet"].id

  private_service_connection {
    name                           = format("%s-%s", module.naming.private_service_connection.name, "acr")
    is_manual_connection           = false
    private_connection_resource_id = data.azurerm_container_registry.acr[count.index].id
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name                 = format("%s-%s", module.naming.private_dns_zone_group.name, "acr")
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns["privatelink.azurecr.io"].id]
  }
}

resource "azurerm_private_endpoint" "kv" {
  count               = contains(var.private_dns_zones, "privatelink.vaultcore.azure.net") && var.env != "hub" ? 1 : 0
  name                = format("%s-%s", module.naming.private_endpoint.name, "kv")
  location            = var.location
  resource_group_name = local.rg_name
  subnet_id           = azurerm_subnet.snet["pesubnet"].id

  private_service_connection {
    name                           = format("%s-%s", module.naming.private_service_connection.name, "kv")
    is_manual_connection           = false
    private_connection_resource_id = data.azurerm_key_vault.kv[count.index].id
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = format("%s-%s", module.naming.private_dns_zone_group.name, "kv")
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns["privatelink.vaultcore.azure.net"].id]
  }
}