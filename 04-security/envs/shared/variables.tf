variable "env" {
  type     = string
  nullable = false
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
  default     = "westus"
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
  default = null
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
  default = null
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
  default = null
}
