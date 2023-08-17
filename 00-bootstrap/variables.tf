variable "default_subscription_id" {
  type     = string
  nullable = false
}

variable "terraform_service_principal" {
  type     = string
  nullable = false
}

variable "location" {
  type     = string
  nullable = false
  default  = "westus"
}

