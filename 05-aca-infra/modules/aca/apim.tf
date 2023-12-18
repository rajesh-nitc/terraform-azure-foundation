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

# # resource "azurerm_api_management_api_policy" "policy" {
# #   api_name            = azurerm_api_management_api.api.name
# #   api_management_name = azurerm_api_management_api.api.api_management_name
# #   resource_group_name = azurerm_api_management_api.api.resource_group_name

# #   xml_content = <<XML
# # <policies>
# #   <inbound>
# #     <validate-azure-ad-token tenant-id="${data.azurerm_client_config.current.tenant_id}">
# #       <client-application-ids>
# #           <application-id>${data.azurerm_user_assigned_identity.web.client_id}</application-id>
# #       </client-application-ids>
# #     </validate-azure-ad-token>
# #     <authentication-managed-identity resource="${data.azuread_application.api.client_id}" client-id="${data.azurerm_user_assigned_identity.apim.client_id}" output-token-variable-name="msi-access-token" ignore-error="false"/>
# #     <set-header name="Authorization" exists-action="override">
# #       <value>@("Bearer " + (string)context.Variables["msi-access-token"])</value>
# #     </set-header>
# #   </inbound>
# # </policies>
# # XML
# # }