resource "azurerm_public_ip" "pip" {
  count               = var.enable_nat ? 1 : 0
  name                = format("%s-%s", module.naming.public_ip.name, "nat")
  location            = var.location
  resource_group_name = local.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_public_ip_prefix" "pip" {
  count               = var.enable_nat ? 1 : 0
  name                = format("%s-%s", module.naming.public_ip_prefix.name, "nat")
  location            = var.location
  resource_group_name = local.rg_name
  prefix_length       = 30
  zones               = ["1"]
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "pip_prefix" {
  count               = var.enable_nat ? 1 : 0
  nat_gateway_id      = azurerm_nat_gateway.nat[count.index].id
  public_ip_prefix_id = azurerm_public_ip_prefix.pip[count.index].id
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip" {
  count                = var.enable_nat ? 1 : 0
  nat_gateway_id       = azurerm_nat_gateway.nat[count.index].id
  public_ip_address_id = azurerm_public_ip.pip[count.index].id
}

resource "azurerm_nat_gateway" "nat" {
  count                   = var.enable_nat ? 1 : 0
  name                    = format("%s-%s-%s", "natgw", var.location, var.env)
  location                = var.location
  resource_group_name     = local.rg_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}