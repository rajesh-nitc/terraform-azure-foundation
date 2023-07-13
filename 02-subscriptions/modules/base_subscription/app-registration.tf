resource "random_uuid" "app" {
  for_each = local.filtered_app_repos
}

# redirect uri will be updated manually by developers using
# using az ad app update --id CLIENT_ID --web-redirect-uris URI
resource "azuread_application" "app" {
  for_each         = local.filtered_app_repos
  display_name     = format("%s-%s-%s-%s", "azureadapp", var.bu, var.app, each.key)
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"
  identifier_uris  = ["api://${var.bu}-${var.app}-${each.key}"]

  web {
    redirect_uris = []

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  api {
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
      admin_consent_display_name = "Access example"
      enabled                    = true
      id                         = random_uuid.app[each.key].result
      type                       = "User"
      user_consent_description   = "Allow the application to access example on your behalf."
      user_consent_display_name  = "Access example"
      value                      = "user_impersonation"
    }
  }
}

resource "azuread_application_password" "app" {
  for_each              = local.filtered_app_repos
  application_object_id = azuread_application.app[each.key].id
}