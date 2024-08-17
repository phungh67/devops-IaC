# Global variables, present in almost all modules
variable "region" {
  description = "Main region of AWS resources"
  type        = string
  default     = "us-west-1"
}

variable "resource_prefix" {
  type        = string
  description = "Name prefix for resources for better management"
  default     = "due1"
}

variable "terraform_status" {
  type        = string
  description = "Indicate that infrastructure is managed by Terraform or not"
  default     = "True"
}

variable "key_algorithm" {
  type = string
}

variable "key_bit" {
  type = string
}