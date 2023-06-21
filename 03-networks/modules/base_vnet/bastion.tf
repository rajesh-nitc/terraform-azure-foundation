resource "azurerm_subnet" "bastion" {
  count                = var.enable_bastion && var.env == "hub" ? 1 : 0
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.rg_name
  virtual_network_name = local.vnet_name
  address_prefixes     = var.bastion_address_prefixes
}

resource "azurerm_network_security_group" "bastion" {
  count               = var.enable_bastion && var.env == "hub" ? 1 : 0
  name                = format("%s-%s", module.naming.network_security_group.name, "bastion")
  location            = var.location
  resource_group_name = local.rg_name

  security_rule {
    name                       = "AllowHTTPSInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowGatewayManagerInbound"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowAzureLBInbound"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowBastionHostCommunication"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["5701", "8080"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowRdpSshOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowBastionHostCommunicationOutbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["5701", "8080"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowAzureCloudOutbound"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443"]
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
  }
  security_rule {
    name                       = "AllowGetSessionInformation"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80"]
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  count                     = var.enable_bastion && var.env == "hub" ? 1 : 0
  subnet_id                 = azurerm_subnet.bastion[count.index].id
  network_security_group_id = azurerm_network_security_group.bastion[count.index].id
  depends_on                = [azurerm_bastion_host.bastion]
}

resource "azurerm_public_ip" "bastion" {
  count               = var.enable_bastion && var.env == "hub" ? 1 : 0
  name                = format("%s-%s", module.naming.public_ip.name, "bastion")
  location            = var.location
  resource_group_name = local.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Naming module currently produce wrong slug for bastion
# once the following pr get merged, we should be able to use the naming module without a diff
# https://github.com/Azure/terraform-azurerm-naming/pull/92
resource "azurerm_bastion_host" "bastion" {
  count = var.enable_bastion && var.env == "hub" ? 1 : 0
  name  = format("%s-%s-%s", "bas", var.env, var.location)
  # name                = module.naming.bastion_host.name
  location            = var.location
  resource_group_name = local.rg_name
  sku                 = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion[count.index].id
    public_ip_address_id = azurerm_public_ip.bastion[count.index].id
  }
}