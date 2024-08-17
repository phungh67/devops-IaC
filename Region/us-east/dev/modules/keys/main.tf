resource "tls_private_key" "ssh_key_instances" {
  algorithm = var.key_algorithm
  rsa_bits  = var.key_bit
}

resource "aws_key_pair" "common_key" {
  key_name   = "${var.resource_prefix}-common-key"
  public_key = tls_private_key.ssh_key_instances.public_key_openssh
}