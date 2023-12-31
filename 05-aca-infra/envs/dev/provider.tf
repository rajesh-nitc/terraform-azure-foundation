terraform {
  required_version = ">= 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.61.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.39.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.0"
    }
  }
}

provider "azurerm" {
  use_oidc                   = true
  skip_provider_registration = true
  subscription_id            = "1b668524-37b9-410f-aede-fca0b2f2ee06"
  storage_use_azuread        = true
  features {}
}

provider "azuread" {

}

provider "github" {
  # set GITHUB_TOKEN environment variable
  # Is it available on github action ? 
}
