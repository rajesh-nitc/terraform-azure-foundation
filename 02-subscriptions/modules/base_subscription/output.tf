output "aad_auth_client_id" {
  value = [
    for k, v in local.filtered_app_cicd_web_repos :
    azuread_application.authenticate_users[k].application_id
  ]
  sensitive   = false
  description = "Add aad auth identity provider manually using this"
}

output "aad_auth_secret" {
  value = [
    for k, v in local.filtered_app_cicd_web_repos :
    azuread_application_password.authenticate_users[k].value
  ]
  sensitive   = true
  description = "Add aad auth identity provider manually using this"
}

