resource "aws_instance" "bastion_host" {
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = concat(["${var.bastion_sg}"], ["${var.common_sg}"])
  subnet_id       = var.public_subnets[0]
  ami             = var.default_ami

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  tags = {
    "Name"      = "${var.resource_prefix}-bastion-machine"
    "Owner"     = "huyhoang.ph"
    "Terraform" = "${var.terraform_status}"
  }
}

resource "aws_eip_association" "bastion_association" {
  instance_id   = aws_instance.bastion_host.id
  allocation_id = var.bastion_eip
}
