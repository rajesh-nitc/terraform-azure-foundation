# so that platform team can run terraform on project-level infra
resource "azurerm_role_assignment" "tf_state" {
  scope                = azurerm_storage_container.tfstate.resource_manager_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_service_principal.terraform.object_id
}