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
