resource "azurerm_resource_group" "rg" {
  name     = module.naming.resource_group.name
  location = var.location
}