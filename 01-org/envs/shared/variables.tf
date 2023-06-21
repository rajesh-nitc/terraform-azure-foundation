variable "subscription_management_suffix" {
  type        = string
  nullable    = false
  description = "description"
}

variable "subscription_connectivity_suffix" {
  type        = string
  nullable    = false
  description = "description"
}

variable "allowed_locations" {
  type        = list(string)
  nullable    = false
  description = "description"
}

variable "location" {
  type        = string
  nullable    = false
  description = "description"
}

variable "law_solutions" {
  type = list(object({
    name      = string
    publisher = string,
    product   = string,

  }))
  default     = []
  nullable    = false
  description = "description"
}

variable "log_categories" {
  type        = list(string)
  nullable    = false
  description = "description"
}

variable "group_roles" {
  type    = map(list(string))
  default = {}
}