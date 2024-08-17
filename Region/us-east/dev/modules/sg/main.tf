locals {
  Environment   = "Development"
  ssh_port      = "22"
  ip_protocol   = "tcp"
  traffic_port  = ["80", "443"]
  database_port = "3306"
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
  tags = {
    "Name"        = "${var.resource_prefix}-bastion-sg"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_security_group" "basic_allow_internet" {
  name        = "${var.resource_prefix}-allow-internet-sg"
  description = "SG for all resources that need to access to The Internet"
  vpc_id      = var.vpc_id
  tags = {
    "Name"        = "${var.resource_prefix}-allow-internet-sg"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_security_group" "basic_was" {
  name        = "${var.resource_prefix}-was-sg"
  description = "SG for Web Application Server machines"
  vpc_id      = var.vpc_id
  tags = {
    "Name"        = "${var.resource_prefix}-was-sg"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_security_group" "basic_elb" {
  name        = "${var.resource_prefix}-elb-sg"
  description = "SG for ELB to receive traffics"
  vpc_id      = var.vpc_id
  tags = {
    "Name"        = "${var.resource_prefix}-elb-sg"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_security_group" "basic_database" {
  name        = "${var.resource_prefix}-database-sg"
  description = "SG for database"
  vpc_id      = var.vpc_id
  tags = {
    "Name"        = "${var.resource_prefix}-database-sg"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "bastion_host_allow_ssh" {
  security_group_id = aws_security_group.basic_bastion_host.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = local.ssh_port
  ip_protocol       = local.ip_protocol
  to_port           = local.ssh_port
  description       = "Allow SSH from source"
}

resource "aws_vpc_security_group_egress_rule" "bastion_to_common" {
  security_group_id            = aws_security_group.basic_bastion_host.id
  referenced_security_group_id = aws_security_group.basic_allow_common.id
  from_port                    = local.ssh_port
  ip_protocol                  = local.ip_protocol
  to_port                      = local.ssh_port
  description                  = "Allow Bastion to ssh to all machines"
}

resource "aws_vpc_security_group_ingress_rule" "common_allow_bastion" {
  security_group_id            = aws_security_group.basic_allow_common.id
  referenced_security_group_id = aws_security_group.basic_bastion_host.id
  from_port                    = local.ssh_port
  ip_protocol                  = local.ip_protocol
  to_port                      = local.ssh_port
  description                  = "Allow SSH traffic from bastion"
}

resource "aws_vpc_security_group_ingress_rule" "elb_allow_public" {
  count             = length(local.traffic_port)
  security_group_id = aws_security_group.basic_elb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = element(local.traffic_port, count.index)
  ip_protocol       = local.ip_protocol
  to_port           = element(local.traffic_port, count.index)
  description       = "Allow public access on port ${element(local.traffic_port, count.index)} from ELB"
}

resource "aws_vpc_security_group_egress_rule" "elb_route_to_was" {
  count                        = length(local.traffic_port)
  security_group_id            = aws_security_group.basic_elb.id
  referenced_security_group_id = aws_security_group.basic_was.id
  from_port                    = element(local.traffic_port, count.index)
  ip_protocol                  = local.ip_protocol
  to_port                      = element(local.traffic_port, count.index)
  description                  = "Allow traffic from ELB port ${element(local.traffic_port, count.index)} to WAS"
}

resource "aws_vpc_security_group_ingress_rule" "was_receive_elb" {
  count                        = length(local.traffic_port)
  security_group_id            = aws_security_group.basic_was.id
  referenced_security_group_id = aws_security_group.basic_elb.id
  from_port                    = element(local.traffic_port, count.index)
  ip_protocol                  = local.ip_protocol
  to_port                      = element(local.traffic_port, count.index)
  description                  = "Receive traffic from ELB port ${element(local.traffic_port, count.index)}"
}

resource "aws_vpc_security_group_egress_rule" "was_to_database" {
  security_group_id            = aws_security_group.basic_was.id
  referenced_security_group_id = aws_security_group.basic_database.id
  from_port                    = local.database_port
  ip_protocol                  = local.ip_protocol
  to_port                      = local.database_port
}