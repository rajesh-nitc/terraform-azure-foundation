resource "azurerm_container_registry" "acr" {
  name                          = module.naming.container_registry.name
  resource_group_name           = local.rg_name
  location                      = var.location
  sku                           = "Premium"
  admin_enabled                 = false # using uai to pull images
  public_network_access_enabled = true  # using github action to push images
  network_rule_bypass_option    = "AzureServices"
}

