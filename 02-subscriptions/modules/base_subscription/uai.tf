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

# Federate infra-cicd 
resource "azurerm_federated_identity_credential" "uai_infra_cicd" {
  name                = format("%s-%s-%s-%s-%s", "uaif", local.infra_cicd, var.bu, var.app, var.env)
  resource_group_name = local.rg_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.uai[local.infra_cicd].id
  subject             = "repo:${data.github_repository.repo.full_name}:environment:${var.env}"
}
