variable "mg_root_display_name" {
  type        = string
  nullable    = false
  description = "description"
}

variable "mgs" {
  type        = list(string)
  nullable    = false
  description = "description"
}

variable "management_subscription_id" {
  type        = string
  nullable    = false
  description = "description"
}

variable "allowed_locations" {
  type        = list(string)
  nullable    = false
  description = "description"
}

variable "exempt_vm_ids" {
  type        = list(string)
  nullable    = false
  description = "description"
}

variable "exempt_user_object_ids" {
  type        = list(string)
  nullable    = false
  description = "description"
}
