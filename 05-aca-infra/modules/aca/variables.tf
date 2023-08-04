variable "env" {
  type     = string
  nullable = false
}

variable "bu" {
  type     = string
  nullable = false
}

variable "app" {
  type     = string
  nullable = false
}

variable "location" {
  type     = string
  nullable = false
  default  = "westus"
}

variable "deploy_appgw" {
  type     = bool
  nullable = false
  default  = true
}

variable "apps" {
  type = map(object({
    app_type    = string
    external    = bool
    target_port = number

  }))
  nullable = false
  default  = {}
}