resource "azurerm_public_ip" "pip" {
  for_each            = { for i in local.all_snets : i.name => i if try(try(i.enable_nat, false), false) }
  name                = format("%s-%s-%s", module.naming.public_ip.name, each.key, "nat")
  location            = var.location
  resource_group_name = local.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_public_ip_prefix" "pip" {
  for_each            = { for i in local.all_snets : i.name => i if try(i.enable_nat, false) }
  name                = format("%s-%s-%s", module.naming.public_ip_prefix.name, each.key, "nat")
  location            = var.location
  resource_group_name = local.rg_name
  prefix_length       = 30
  zones               = ["1"]
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "pip_prefix" {
  for_each            = { for i in local.all_snets : i.name => i if try(i.enable_nat, false) }
  nat_gateway_id      = azurerm_nat_gateway.nat[each.key].id
  public_ip_prefix_id = azurerm_public_ip_prefix.pip[each.key].id
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip" {
  for_each             = { for i in local.all_snets : i.name => i if try(i.enable_nat, false) }
  nat_gateway_id       = azurerm_nat_gateway.nat[each.key].id
  public_ip_address_id = azurerm_public_ip.pip[each.key].id
}

resource "azurerm_nat_gateway" "nat" {
  for_each                = { for i in local.all_snets : i.name => i if try(i.enable_nat, false) }
  name                    = format("%s-%s-%s-%s", "natgw", each.key, var.location, var.env)
  location                = var.location
  resource_group_name     = local.rg_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_subnet_nat_gateway_association" "nat" {
  for_each       = { for i in local.all_snets : i.name => i if try(i.enable_nat, false) }
  subnet_id      = azurerm_subnet.snet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.nat[each.key].id
}