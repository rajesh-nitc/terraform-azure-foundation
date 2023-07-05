resource "azurerm_key_vault" "kv" {
  count                           = var.enable_kv ? 1 : 0
  name                            = module.naming.key_vault.name
  resource_group_name             = local.rg_name
  location                        = var.location
  sku_name                        = "standard"
  tenant_id                       = local.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  public_network_access_enabled   = true
  enable_rbac_authorization       = true
  enabled_for_template_deployment = true

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = ["0.0.0.0/0"]
    virtual_network_subnet_ids = null
  }
}