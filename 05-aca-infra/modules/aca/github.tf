resource "github_actions_environment_secret" "apim_key" {
  repository      = split("/", var.repo)[1]
  environment     = var.env
  secret_name     = "REACT_APP_APIM_KEY"
  plaintext_value = random_password.apim.result
}