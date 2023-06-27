output "uais" {
  value      = azurerm_user_assigned_identity.uai
  sensitive  = false
  depends_on = []
}
