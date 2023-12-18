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

variable "publisher_name" {
  type     = string
  nullable = false
}

variable "publisher_email" {
  type     = string
  nullable = false
}

variable "repo" {
  type     = string
  nullable = false
}