resource "azurerm_resource_group" "rg" {
  name     = format("%s-%s", module.naming.resource_group.name, "net")
  location = var.location
}