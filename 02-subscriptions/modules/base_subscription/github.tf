resource "github_repository_environment" "env" {
  for_each    = var.uai_repos
  environment = var.env
  repository  = split("/", each.value)[1]
}

resource "github_actions_environment_secret" "client_id" {
  for_each        = local.filtered_cicd_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "CLIENT_ID") # Error: secret names can only contain alphanumeric characters or underscores
  plaintext_value = azurerm_user_assigned_identity.uai[each.key].client_id
}

resource "github_actions_environment_secret" "subscription_id" {
  for_each        = local.filtered_cicd_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = "SUBSCRIPTION_ID"
  plaintext_value = local.sub_id
}

resource "github_actions_environment_secret" "tenant_id" {
  for_each        = local.filtered_cicd_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = "TENANT_ID"
  plaintext_value = local.tenant_id
}

# resource "github_actions_environment_secret" "acr" {
#   for_each        = local.filtered_app_cicd_repos
#   repository      = split("/", each.value)[1]
#   environment     = github_repository_environment.env[each.key].environment
#   secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "ACR_NAME")
#   plaintext_value = azurerm_container_registry.acr.name
# }

resource "github_actions_environment_secret" "rg" {
  for_each        = local.filtered_app_cicd_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "RG_NAME")
  plaintext_value = local.rg_name
}

resource "github_actions_environment_secret" "uai_id" {
  for_each        = local.filtered_app_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "CONTAINER_UAI_ID")
  plaintext_value = azurerm_user_assigned_identity.uai[each.key].id
}

resource "github_actions_environment_secret" "aad_client_id" {
  for_each        = local.filtered_app_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "AAD_CLIENT_ID")
  plaintext_value = azuread_application.app[each.key].application_id
}

resource "github_actions_environment_secret" "aad_secret" {
  for_each        = local.filtered_app_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "AAD_SECRET")
  plaintext_value = azuread_application_password.app[each.key].value
}