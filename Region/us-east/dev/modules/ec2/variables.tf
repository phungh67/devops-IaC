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

variable "main_vpc_id" {
  type        = string
  description = "The default VPC for this project"
}

variable "bastion_sg" {
  type        = string
  description = "SG associated with Bastion host"
}

variable "common_sg" {
  type        = string
  description = "SG that associated with almost all instances, resources in this VPC"
}

variable "elb_sg" {
  type        = string
  description = "SG that associated with ELB"
}

variable "database_sg" {
  type        = string
  description = "SG that associated with database servers"
}

variable "internet_sg" {
  type        = string
  description = "SG that allows associcated resources go to the Internet"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets"
}

variable "database_subnets" {
  type        = list(string)
  description = "List of subnets for database serversF"
}

