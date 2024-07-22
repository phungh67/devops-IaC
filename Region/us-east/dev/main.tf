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