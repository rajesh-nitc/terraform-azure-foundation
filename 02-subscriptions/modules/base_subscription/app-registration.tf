resource "random_uuid" "api" {
}

resource "azuread_application" "web" {
  display_name     = format("%s-%s-%s-%s-%s", "app", var.bu, var.app, "web", var.env)
  identifier_uris  = ["api://${format("%s-%s-%s-%s", var.bu, var.app, "web", var.env)}"]
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  single_page_application {
    redirect_uris = []
  }

  web {
    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  api {
    requested_access_token_version = 2
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  required_resource_access {
    resource_app_id = azuread_application.api.application_id

    resource_access {
      id   = random_uuid.api.result
      type = "Scope"
    }
  }

  # Redirect uris will be updated manually by azure-devs group
  lifecycle {
    ignore_changes = [
      single_page_application[0].redirect_uris,
    ]
  }

}

resource "azuread_application" "api" {
  display_name     = format("%s-%s-%s-%s-%s", "app", var.bu, var.app, "api", var.env)
  identifier_uris  = ["api://${format("%s-%s-%s-%s", var.bu, var.app, "api", var.env)}"]
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  web {
    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }

  api {
    mapped_claims_enabled          = false
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Allow client to access backend api on behalf of the signed-in user."
      admin_consent_display_name = "Access backend api"
      enabled                    = true
      id                         = random_uuid.api.result
      type                       = "User"
      user_consent_description   = "Allow client to access backend api on your behalf."
      user_consent_display_name  = "Access backend api"
      value                      = "user_impersonation"
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

}