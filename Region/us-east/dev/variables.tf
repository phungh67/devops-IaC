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

# Variables depends on modules
# VPC

variable "vpc_cidr" {
  description = "CIDR of main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_cidr" {
  description = "CIDR for public subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "private_cidr" {
  description = "CIDR for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.21.0/24", "10.0.31.0/24"]
}

variable "database_cidr" {
  description = "CIDR for database dedicated subnets"
  type        = list(string)
  default     = ["10.0.12.0/24", "10.0.22.0/24", "10.0.32.0/24"]
}

# TLS SSH key
variable "key_algorithm" {
  type        = string
  description = "The algorithm to create key"
  default     = "RSA"
}

variable "key_bit" {
  type        = string
  description = "Number of bit used for key creating process"
  default     = "4096"
}

# EC2 instances related key
variable "instance_base_ami" {
  type        = string
  description = "The base customized AMI with all necessary packages"
  default     = "ami-06b21ccaeff8cd686"
}

variable "instance_type" {
  type        = string
  description = "The default type of all instances"
  default     = "t2.micro"
}

variable "default_key" {
  type        = string
  description = "The default SSH key using for SSH process"
  default     = null
}
