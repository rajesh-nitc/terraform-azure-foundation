# Policy set definitions https://github.com/Azure/azure-policy/tree/aac5440127e712c84b79fdaa75171362ba502a57/built-in-policies/policySetDefinitions 
# CIS Microsoft Azure Foundations Benchmark v1.4.0
resource "azurerm_management_group_policy_assignment" "cis" {
  name                 = "psd-regulatory-cis"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/c3f5c4d9-9a1d-4a99-85c0-7f93e384d5c5"
  management_group_id  = local.scope
}

# Policy definitions https://github.com/Azure/azure-policy/tree/aac5440127e712c84b79fdaa75171362ba502a57/built-in-policies/policyDefinitions
# Allowed locations
resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "pd-general-allow-locs"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  management_group_id  = local.scope
  parameters = jsonencode(
    {
      listOfAllowedLocations : { "value" : var.allowed_locations }
    }
  )
}
