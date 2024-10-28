resource "tls_private_key" "ssh_key_instances" {
  algorithm = var.key_algorithm
  rsa_bits  = var.key_bit
}

resource "aws_key_pair" "common_key" {
  key_name   = "${var.resource_prefix}-common-key"
  public_key = tls_private_key.ssh_key_instances.public_key_openssh
  tags = {
    "Name"      = "${var.resource_prefix}-common-key"
    "Terraform" = "${var.terraform_status}"
  }
}

resource "local_file" "ssh_key" {
  filename        = "${var.resource_prefix}-ssh-key"
  file_permission = "600"
  content         = tls_private_key.ssh_key_instances.private_key_openssh
}