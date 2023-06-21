variable "env" {
  type     = string
  nullable = false
}

variable "location" {
  type    = string
  default = "westus"
}

variable "firewall_name" {
  description = ""
  type        = string
  nullable    = false
}

variable "firewall_public_ip" {
  description = ""
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = ""
  type        = string
  nullable    = false
}