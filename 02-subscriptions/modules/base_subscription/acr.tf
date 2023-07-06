# resource "azurerm_container_registry" "acr" {
#   name                = module.naming.container_registry.name
#   resource_group_name = local.rg_name
#   location            = var.location

#   sku = "Basic" #"Premium"

#   admin_enabled                 = false
#   public_network_access_enabled = true # Can we push image from github if it is false?
#   network_rule_bypass_option    = "AzureServices"

# }

