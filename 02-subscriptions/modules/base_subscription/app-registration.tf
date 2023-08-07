resource "random_uuid" "web" {
}

resource "random_uuid" "api" {
}

resource "azuread_application" "web" {
  display_name     = format("%s-%s-%s-%s-%s", "app", var.bu, var.app, "web", var.env)
  identifier_uris  = ["api://${format("%s-%s-%s-%s", var.bu, var.app, "web", var.env)}"]
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  web {
    redirect_uris = []

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  api {
    mapped_claims_enabled          = false
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
      admin_consent_display_name = "Access example"
      enabled                    = true
      id                         = random_uuid.web.result
      type                       = "User"
      user_consent_description   = "Allow the application to access example on your behalf."
      user_consent_display_name  = "Access example"
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

  # Redirect uris will be updated manually by azure-devs group
  lifecycle {
    ignore_changes = [
      web[0].redirect_uris,
    ]
  }

}

# resource "azuread_application" "api" {
#   display_name     = format("%s-%s-%s-%s-%s", "app", var.bu, var.app, "api", var.env)
#   identifier_uris  = ["api://${format("%s-%s-%s-%s", var.bu, var.app, "api", var.env)}"]
#   owners           = [data.azuread_client_config.current.object_id]
#   sign_in_audience = "AzureADMyOrg"

#   web {
#     implicit_grant {
#       access_token_issuance_enabled = false
#       id_token_issuance_enabled     = true
#     }
#   }

#   api {
#     mapped_claims_enabled          = false
#     requested_access_token_version = 2

#     known_client_applications = [
#       azuread_application.web.application_id,
#     ]

#     oauth2_permission_scope {
#       admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
#       admin_consent_display_name = "Access example"
#       enabled                    = true
#       id                         = random_uuid.api.result
#       type                       = "User"
#       user_consent_description   = "Allow the application to access example on your behalf."
#       user_consent_display_name  = "Access example"
#       value                      = "user_impersonation"
#     }
#   }

#   required_resource_access {
#     resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

#     resource_access {
#       id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
#       type = "Scope"
#     }
#   }

# }