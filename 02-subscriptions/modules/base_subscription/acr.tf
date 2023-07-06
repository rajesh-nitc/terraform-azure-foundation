# resource "azurerm_container_registry" "acr" {
#   for_each            = local.filtered_app_cicd_repos
#   name                = format("%s%s", module.naming.container_registry.name, join("", split("-", each.key)))
#   resource_group_name = local.rg_name
#   location            = var.location

#   sku = "Basic" #"Premium"

#   admin_enabled                 = false
#   public_network_access_enabled = true # Can we push image from github if it is false?
#   network_rule_bypass_option    = "AzureServices"

# }

