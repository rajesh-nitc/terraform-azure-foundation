locals {
  rg_name   = azurerm_resource_group.net.name
  vnet_name = azurerm_virtual_network.vnet.name
}

module "naming" {
  source = "Azure/naming/azurerm"

  suffix = concat(
    var.env != "hub"
    ? [var.bu, var.app]
    : [],
    [var.env, var.location]
  )
}