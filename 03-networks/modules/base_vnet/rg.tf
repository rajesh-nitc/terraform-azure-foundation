resource "azurerm_resource_group" "net" {
  name     = format("%s-%s", module.naming.resource_group.name, "net")
  location = var.location
}

