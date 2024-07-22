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

variable "az_list" {
  type        = list(string)
  description = "List of availability zones associate with region"
}

variable "terraform_status" {
  type        = string
  description = "Indicate that infrastructure is managed by Terraform or not"
  default     = "True"
}

# Variables for SG
variable "vpc_id" {
  description = "The ID of main VPC from VPC module"
  type = string
}