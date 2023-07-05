resource "azurerm_resource_group" "rg" {
  name     = module.naming.resource_group.name
  location = var.location
}

resource "azurerm_resource_group" "tfstate" {
  name     = format("%s-%s", module.naming.resource_group.name, "tf")
  location = var.location
}