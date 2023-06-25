resource "azurerm_public_ip" "firewall" {
  count               = var.enable_firewall && var.env == "hub" ? 1 : 0
  name                = format("%s-%s", module.naming.public_ip.name, "fw")
  location            = var.location
  resource_group_name = local.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  count               = var.enable_firewall && var.env == "hub" ? 1 : 0
  name                = module.naming.firewall.name
  location            = var.location
  resource_group_name = local.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  dns_servers         = ["168.63.129.16"]

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.firewall[count.index].id
    public_ip_address_id = azurerm_public_ip.firewall[count.index].id
  }
}

