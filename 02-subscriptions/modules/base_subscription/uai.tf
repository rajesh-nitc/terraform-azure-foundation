# Unsupported regions for user-assigned managed identities
# https://learn.microsoft.com/en-gb/azure/active-directory/workload-identities/workload-identity-federation-considerations#unsupported-regions-user-assigned-managed-identities

resource "azurerm_user_assigned_identity" "uai" {
  for_each            = var.uai_roles
  name                = format("%s-%s-%s-%s-%s", "uai", each.key, var.bu, var.app, var.env)
  resource_group_name = local.rg_name
  location            = var.location
}

resource "azurerm_role_assignment" "uai" {
  for_each = {
    for i in local.uai_roles : "${i.role}-${i.member}" => {
      role   = i.role
      member = i.member
    }
  }
  scope                = local.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.uai[each.value.member].principal_id
}

# Federate repos provided by user that contain "cicd" 
resource "azurerm_federated_identity_credential" "cicd" {
  for_each            = local.filtered_uai_repos
  name                = format("%s-%s-%s-%s-%s", "uaif", each.key, var.bu, var.app, var.env)
  resource_group_name = local.rg_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.uai[each.key].id
  subject             = "repo:${each.value}:environment:${var.env}"
}
