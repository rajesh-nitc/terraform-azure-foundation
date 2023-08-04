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