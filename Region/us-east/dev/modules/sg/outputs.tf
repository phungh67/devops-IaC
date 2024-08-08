output "bastion_sg" {
  value = aws_security_group.basic_bastion_host.id
}

output "common_sg" {
  value = aws_security_group.basic_allow_common.id
}

output "internet_allow_sg" {
  value = aws_security_group.basic_allow_internet.id
}

output "basic_elb_sg" {
  value = aws_security_group.basic_elb.id
}

output "basic_was_sg" {
  value = aws_security_group.basic_was.id
}

output "database_sg" {
  value = aws_security_group.basic_database.id
}