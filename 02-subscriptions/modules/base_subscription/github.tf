resource "github_repository_environment" "env" {
  for_each    = local.filtered_uai_repos
  environment = var.env
  repository  = split("/", each.value)[1]
}

# Error: secret names can only contain alphanumeric characters or underscores and must not start with a number
resource "github_actions_environment_secret" "client_id" {
  for_each        = local.filtered_uai_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = format("%s_%s", upper(replace(each.key, "-", "_")), "CLIENT_ID")
  plaintext_value = azurerm_user_assigned_identity.uai[each.key].client_id
}

resource "github_actions_environment_secret" "subscription_id" {
  for_each        = local.filtered_uai_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = "SUBSCRIPTION_ID"
  plaintext_value = local.sub_id
}

resource "github_actions_environment_secret" "tenant_id" {
  for_each        = local.filtered_uai_repos
  repository      = split("/", each.value)[1]
  environment     = github_repository_environment.env[each.key].environment
  secret_name     = "TENANT_ID"
  plaintext_value = local.tenant_id
}