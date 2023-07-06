resource "github_repository_environment" "env" {
  for_each    = local.filtered_cicd_repos
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

resource "github_actions_environment_secret" "acr" {
  for_each        = local.filtered_app_cicd_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "ACR_NAME")
  plaintext_value = azurerm_container_registry.acr[each.key].name
}

resource "github_actions_environment_secret" "rg" {
  for_each        = local.filtered_app_cicd_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "RG_NAME")
  plaintext_value = local.rg_name
}

# resource "github_actions_environment_secret" "acr_username" {
#   for_each        = local.filtered_app_cicd_repos
#   repository      = split("/", each.value)[1]
#   environment     = github_repository_environment.env[each.key].environment
#   secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "ACR_USERNAME")
#   plaintext_value = azurerm_container_registry.acr[each.key].admin_username
# }

# resource "github_actions_environment_secret" "acr_password" {
#   for_each        = local.filtered_app_cicd_repos
#   repository      = split("/", each.value)[1]
#   environment     = github_repository_environment.env[each.key].environment
#   secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "ACR_PASSWORD")
#   plaintext_value = azurerm_container_registry.acr[each.key].admin_password
# }