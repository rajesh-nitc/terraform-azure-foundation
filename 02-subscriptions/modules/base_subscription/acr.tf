# resource "azurerm_container_registry" "acr" {
#   name                          = module.naming.container_registry.name
#   resource_group_name           = local.rg_name
#   location                      = var.location
#   sku                           = "Basic"
#   admin_enabled                 = false # Openid auth with uai is used
#   public_network_access_enabled = true  # To push image from github action
#   network_rule_bypass_option    = "AzureServices"
# }

