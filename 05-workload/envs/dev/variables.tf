variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
  default     = "westus"
}

variable "resource_group_name" {
  description = ""
  type        = string
  nullable    = false
}