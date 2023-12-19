# # Add apim in external mode
# resource "azurerm_api_management" "apim" {
#   name                = module.naming.api_management.name
#   resource_group_name = local.rg_name
#   location            = var.location
#   publisher_name      = var.publisher_name
#   publisher_email     = var.publisher_email

#   sku_name                      = "Developer_1"
#   public_network_access_enabled = true
#   virtual_network_type          = "External"

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [data.azurerm_user_assigned_identity.apim.id]
#   }

#   virtual_network_configuration {
#     subnet_id = data.azurerm_subnet.apim.id
#   }

# }

# # apim subscriction key
# resource "random_password" "apim" {
#   length  = 32
#   special = false
# }

# # apim subscriction key with scope: all apis
# resource "azurerm_api_management_subscription" "scope_all_apis" {
#   api_management_name = azurerm_api_management.apim.name
#   resource_group_name = local.rg_name
#   primary_key         = random_password.apim.result
#   state               = "active"
#   display_name        = format("%s-%s-%s-%s-%s", "apim-key", var.bu, var.app, var.location, var.env)
# }

# resource "azurerm_api_management_product" "product" {
#   product_id            = "api"
#   api_management_name   = azurerm_api_management.apim.name
#   resource_group_name   = local.rg_name
#   display_name          = "API Product"
#   subscription_required = true
#   approval_required     = false
#   published             = true
# }