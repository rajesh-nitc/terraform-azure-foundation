resource "azuread_group" "group" {
  for_each                = var.group_roles
  display_name            = format("%s-%s-%s", each.key, var.bu, var.app)
  security_enabled        = true
  prevent_duplicate_names = true
  assignable_to_role      = true
  owners                  = [data.azurerm_client_config.current.object_id]
}

resource "azurerm_role_assignment" "group" {
  for_each = {
    for i in local.group_roles : "${i.role}-${i.member}" => {
      role   = i.role
      member = i.member
    }
  }
  scope                = local.id
  role_definition_name = each.value.role
  principal_id         = azuread_group.group[each.value.member].object_id
}

# Allow developers to create app registrations in azure ad
resource "azuread_directory_role" "app_developer" {
  display_name = "Application Developer"
}

resource "azuread_directory_role_assignment" "devs_group" {
  role_id             = azuread_directory_role.app_developer.template_id
  principal_object_id = azuread_group.group["azure-devs"].object_id
}

# So that [webspa/web]-cicd (as part of github actions) is able to update the redirect URI in aad app
# [webspa/web]-cicd workflow is not able to update redirect uri with "Application Developer" role
resource "azuread_directory_role" "app_cicd" {
  display_name = "Application Administrator"
}

resource "azuread_directory_role_assignment" "app_cicd" {
  for_each            = local.filtered_app_web_repos
  role_id             = azuread_directory_role.app_cicd.template_id
  principal_object_id = azurerm_user_assigned_identity.uai[each.key].principal_id
}