resource "azurerm_public_ip" "bastion" {
  count               = length(var.bastion_address_prefixes) > 0 && var.env == "hub" ? 1 : 0
  name                = format("%s-%s", module.naming.public_ip.name, "bastion")
  location            = var.location
  resource_group_name = local.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# module naming does not support bastion_host
resource "azurerm_bastion_host" "bastion" {
  count = length(var.bastion_address_prefixes) > 0 && var.env == "hub" ? 1 : 0
  name  = format("%s-%s-%s", "bas", var.location, var.env)
  # name                = module.naming.bastion_host.name
  location            = var.location
  resource_group_name = local.rg_name
  sku                 = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion[count.index].id
    public_ip_address_id = azurerm_public_ip.bastion[count.index].id
  }
}