variable "subscription_management_suffix" {
  type     = string
  nullable = false
  default  = "management"
}

variable "subscription_connectivity_suffix" {
  type     = string
  nullable = false
  default  = "connectivity"
}

variable "allowed_locations" {
  type     = list(string)
  nullable = false
  default  = ["westus"]
}

variable "location" {
  type     = string
  nullable = false
  default  = "westus"
}

variable "logs" {
  type = list(object({
    category = string
    enabled  = bool
  }))
  nullable = false
}

variable "law_solutions" {
  type = list(object({
    name      = string
    publisher = string,
    product   = string,

  }))

  nullable = false
  default  = []
}

variable "group_roles" {
  type     = map(list(string))
  nullable = false
  default  = {}
}

variable "budget_amount" {
  type     = number
  nullable = false
}

variable "budget_contact_emails" {
  type     = list(string)
  nullable = false
}