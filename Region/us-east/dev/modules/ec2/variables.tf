# Global variables, present in almost all modules
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

variable "default_ami" {
  type        = string
  description = "The default AMI ID when there is no specified"
}

variable "key_name" {
  type        = string
  description = "The name of SSH key for this machine"
}

variable "instance_type" {
  type        = string
  description = "The type of computing unit"
}

variable "bastion_eip" {
  type        = string
  description = "Elastic IP to associate to bastion host"
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

variable "internet_sg" {
  type        = string
  description = "SG that allows associcated resources go to the Internet"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets"
}

