resource "random_uuid" "authenticate_users" {
  for_each = local.filtered_app_cicd_web_repos
}

resource "azuread_application" "authenticate_users" {
  for_each         = local.filtered_app_cicd_web_repos
  display_name     = format("%s-%s-%s-%s-%s", "app", var.bu, var.app, split("-", each.key)[0], var.env)
  identifier_uris  = ["api://${format("%s-%s-%s-%s", var.bu, var.app, split("-", each.key)[0], var.env)}"]
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  dynamic "web" {
    for_each = can(regex(".*web.*", each.key)) ? [1] : []

    content {
      redirect_uris = []

      implicit_grant {
        access_token_issuance_enabled = false
        id_token_issuance_enabled     = true
      }


    }
  }

  # Redirect uris will be updated manually by azure-devs group
  lifecycle {
    ignore_changes = [
      single_page_application[0].redirect_uris,
      web[0].redirect_uris,
    ]
  }

}

resource "azuread_application_password" "authenticate_users" {
  for_each              = local.filtered_app_cicd_web_repos
  application_object_id = azuread_application.authenticate_users[each.key].id
}