# data "azurerm_virtual_network" "hub_vnet" {
#   count               = var.env != "hub" ? 1 : 0
#   name                = format("%s-hub-%s", "vnet", var.location)
#   resource_group_name = format("%s-hub-%s", "rg", var.location)
# }