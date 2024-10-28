output "aws_common_key" {
  value = aws_key_pair.common_key.key_name
}

output "ssh_key" {
  value = tls_private_key.ssh_key_instances.private_key_openssh
}