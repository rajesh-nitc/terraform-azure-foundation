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
    condition     = contains(keys(var.uai_roles), "infra-cicd")
    error_message = "Must have a key named infra-cicd"
  }
}

variable "uai_repos" {
  type    = map(string)
  default = {}
}

variable "group_roles" {
  type    = map(list(string))
  default = {}
}

variable "enable_kv" {
  type    = bool
  default = true
}
