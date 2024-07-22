locals {
  Environment = "Development"
}

resource "aws_security_group" "basic_allow_common" {
  name        = "${var.resource_prefix}-common-sg"
  description = "SG for common purpose between resources"
  vpc_id      = var.vpc_id
  tags = {
    "Name"        = "${var.resource_prefix}-common-sg"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_security_group" "basic_bastion_host" {
  name        = "${var.resource_prefix}-bastion-sg"
  description = "SG for bastion host"
  vpc_id      = var.vpc_id
}
