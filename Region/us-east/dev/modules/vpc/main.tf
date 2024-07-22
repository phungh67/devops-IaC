locals {
  Environment = "Development"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name"        = "${var.resource_prefix}-main-vpc"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_cidr)
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = element(var.az_list, count.index)
  cidr_block        = element(var.public_cidr, count.index)
  tags = {
    "Name"        = "${var.resource_prefix}-pub-subnet-00${count.index + 1}"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_cidr)
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = element(var.az_list, count.index)
  cidr_block        = element(var.private_cidr, count.index)
  tags = {
    "Name"        = "${var.resource_prefix}-pri-subnet-00${count.index + 1}"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_subnet" "database_subnets" {
  count             = length(var.database_cidr)
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = element(var.az_list, count.index)
  cidr_block        = element(var.database_cidr, count.index)
  tags = {
    "Name"        = "${var.resource_prefix}-db-subnet-00${count.index + 1}"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_internet_gateway" "public-gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "Name"        = "${var.resource_prefix}-main-igw"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-gateway.id
  }

  tags = {
    "Name"        = "${var.resource_prefix}-pub-route-table"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    "Name"        = "${var.resource_prefix}-nat-eip"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    "Name"        = "${var.resource_prefix}-main-nat-gateway"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat.id
  }

  tags = {
    "Name"        = "${var.resource_prefix}-pri-route-table"
    "Terraform"   = "${var.terraform_status}"
    "Environment" = local.Environment
  }
}

resource "aws_route_table_association" "pub_association" {
  count          = length(var.public_cidr)
  subnet_id      = aws_subnet.public_subnets[*].id
  route_table_id = aws_subnet.public_subnets.id
}

resource "aws_route_table_association" "pri_association" {
  count          = length(var.private_cidr)
  subnet_id      = aws_subnet.private_subnets[*].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main_vpc.id
}

