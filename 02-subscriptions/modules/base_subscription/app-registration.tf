resource "random_uuid" "api" {
}

resource "azuread_service_principal" "msgraph" {
  application_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing   = true
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
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    resource_access {
      id   = azuread_service_principal.msgraph.app_role_ids["User.Read.All"]
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
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    resource_access {
      id   = azuread_service_principal.msgraph.app_role_ids["User.Read.All"]
      type = "Scope"
    }
  }

}