resource "random_uuid" "authenticate_users" {
  for_each = local.filtered_app_web_e_auth_repos
}

resource "azuread_application" "authenticate_users" {
  for_each         = local.filtered_app_web_e_auth_repos
  display_name     = format("%s-%s-%s-%s-%s", "app", var.bu, var.app, each.key, var.env)
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"
  identifier_uris  = ["api://${var.bu}-${var.app}-${each.key}-${var.env}"]

  web {
    redirect_uris = [
      # redirect uri will be updated as part of github aca-app workflow
    ]

    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }

  api {
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
      admin_consent_display_name = "Access example"
      enabled                    = true
      id                         = random_uuid.authenticate_users[each.key].result
      type                       = "User"
      user_consent_description   = "Allow the application to access example on your behalf."
      user_consent_display_name  = "Access example"
      value                      = "user_impersonation"
    }
  }
}

resource "azuread_application_password" "authenticate_users" {
  for_each              = local.filtered_app_web_e_auth_repos
  application_object_id = azuread_application.authenticate_users[each.key].id
}