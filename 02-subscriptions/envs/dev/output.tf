output "aad_auth_client_id" {
  value       = module.bu1_app1_sub.aad_auth_client_id
  sensitive   = false
  description = "Add aad auth identity provider manually using this"
}

output "aad_auth_secret" {
  value       = module.bu1_app1_sub.aad_auth_secret
  sensitive   = true
  description = "Add aad auth identity provider manually using this"
}