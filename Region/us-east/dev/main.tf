module "aws-vpc" {
  source           = "./modules/vpc"
  region           = var.region
  resource_prefix  = var.resource_prefix
  terraform_status = var.terraform_status
  az_list          = var.az_list
  vpc_cidr         = var.vpc_cidr
  public_cidr      = var.public_cidr
  private_cidr     = var.private_cidr
}

module "aws-sg" {
  source           = "./modules/sg"
  region           = var.region
  resource_prefix  = var.resource_prefix
  terraform_status = var.terraform_status
  vpc_id           = module.aws-vpc.main_vpc_id
}

module "ssh-key" {
  source           = "./modules/keys"
  resource_prefix  = var.resource_prefix
  terraform_status = var.terraform_status
  key_algorithm    = var.key_algorithm
  key_bit          = var.key_bit
}

module "aws-ec2" {
  source           = "./modules/ec2"
  resource_prefix  = var.resource_prefix
  terraform_status = var.terraform_status
  default_ami      = var.instance_base_ami
  bastion_eip      = module.aws-vpc.bastion_ip
  key_name         = module.ssh-key.aws_common_key
  instance_type    = var.instance_type
  main_vpc_id      = module.aws-vpc.main_vpc_id
  bastion_sg       = module.aws-sg.bastion_sg
  common_sg        = module.aws-sg.common_sg
  internet_sg      = module.aws-sg.internet_allow_sg
  public_subnets   = module.aws-vpc.aws_public_subnet_id
}
