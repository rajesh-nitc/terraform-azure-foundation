output "terraform_sp_client_id" {
  value     = azuread_application.terraform.application_id
  sensitive = false
}

output "terraform_sp_secret" {
  value     = azuread_application_password.terraform.value
  sensitive = true
}
