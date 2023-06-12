output "mg_root_id" {
  value       = azurerm_management_group.root.id
  sensitive   = false
  description = "description"
  depends_on  = []
}
