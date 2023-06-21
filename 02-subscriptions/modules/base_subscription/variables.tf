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
}

variable "group_roles" {
  type    = map(list(string))
  default = {}
}

