resource "azurerm_resource_group" "rg" {
  name     = module.naming.resource_group.name
  location = var.location
}

resource "azurerm_resource_group" "shared" {
  name     = format("%s-%s", module.naming.resource_group.name, "shared")
  location = var.location
}