resource "github_repository_environment" "env" {
  environment = var.env
  repository  = local.gh_repo
}

resource "github_actions_environment_secret" "uai_infra_cicd_client_id" {
  repository      = local.gh_repo
  environment     = github_repository_environment.env.environment
  secret_name     = "INFRA_CICD_CLIENT_ID"
  plaintext_value = azurerm_user_assigned_identity.uai[local.infra_cicd].client_id
}

# we have one repo with various stages where one stage may setup infra cicd and other may setup app cicd 
# In real world, both infra-cicd and app-cicd will have a separate repo
resource "github_actions_environment_secret" "uai_app_cicd_client_id" {
  repository      = local.gh_repo
  environment     = github_repository_environment.env.environment
  secret_name     = "APP_CICD_CLIENT_ID"
  plaintext_value = azurerm_user_assigned_identity.uai[local.app_cicd].client_id
}

resource "github_actions_environment_secret" "subscription_id" {
  repository      = local.gh_repo
  environment     = github_repository_environment.env.environment
  secret_name     = "SUBSCRIPTION_ID"
  plaintext_value = local.sub_id
}

resource "github_actions_environment_secret" "tenant_id" {
  repository      = local.gh_repo
  environment     = github_repository_environment.env.environment
  secret_name     = "TENANT_ID"
  plaintext_value = local.tenant_id
}