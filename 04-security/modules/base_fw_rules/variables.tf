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
  type    = string
  default = "westus"
}

variable "firewall_name" {
  type     = string
  nullable = false
}

variable "firewall_public_ip" {
  type     = string
  nullable = false
}

variable "resource_group_name" {
  type     = string
  nullable = false
}

variable "network_rule_collections" {
  type = list(object({
    name     = string,
    priority = number,
    action   = string,
    rules = list(object({
      name                  = string,
      source_addresses      = list(string),
      source_ip_groups      = list(string),
      destination_ports     = list(string),
      destination_addresses = list(string),
      destination_ip_groups = list(string),
      destination_fqdns     = list(string),
      protocols             = list(string)
    }))
  }))
  nullable = false
  default  = []
}

variable "application_rule_collections" {
  type = list(object({
    name     = string,
    priority = number,
    action   = string,
    rules = list(object({
      name             = string,
      source_addresses = list(string),
      source_ip_groups = list(string),
      target_fqdns     = list(string),
      protocols = list(object({
        port = string,
        type = string
      }))
    }))
  }))
  nullable = false
  default  = []
}

variable "nat_rule_collections" {
  type = list(object({
    name     = string,
    priority = number,
    action   = string,
    rules = list(object({
      name               = string,
      source_addresses   = list(string),
      source_ip_groups   = list(string),
      destination_ports  = list(string),
      translated_port    = number,
      translated_address = string,
      protocols          = list(string)
    }))
  }))
  nullable = false
  default  = []
}
