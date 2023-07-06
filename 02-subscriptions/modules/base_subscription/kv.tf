# resource "azurerm_key_vault" "kv" {
#   name                            = module.naming.key_vault.name
#   resource_group_name             = local.rg_name
#   location                        = var.location
#   sku_name                        = "standard"
#   tenant_id                       = local.tenant_id
#   soft_delete_retention_days      = 7
#   purge_protection_enabled        = false
#   public_network_access_enabled   = true
#   enable_rbac_authorization       = true
#   enabled_for_template_deployment = true
# }