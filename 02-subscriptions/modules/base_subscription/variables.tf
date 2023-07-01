variable "env" {
  type     = string
  nullable = false
}

variable "bu" {
  type    = string
  default = ""
}

variable "app" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = "westus"
}

variable "uai_roles" {
  type    = map(list(string))
  default = {}
  validation {
    condition = (
      contains(keys(var.uai_roles), "infra-cicd")
      && contains(keys(var.uai_roles), "app-cicd")
      && contains(keys(var.uai_roles), "app")
    )
    error_message = "Must have a key named infra-cicd and a key named app-cicd and a key named app"
  }
}

variable "group_roles" {
  type    = map(list(string))
  default = {}
}

variable "enable_acr" {
  type    = bool
  default = true
}

variable "enable_kv" {
  type    = bool
  default = true
}

variable "gh_owner" {
  type     = string
  nullable = false
}

variable "gh_repo" {
  type     = string
  nullable = false
}
