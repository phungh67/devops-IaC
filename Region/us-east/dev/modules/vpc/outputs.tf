output "nat_gateway_ip" {
  value = aws_eip.nat_eip.public_ip
}

output "aws_public_subnet_id" {
  value = values(aws_subnet.public_subnets)[*].id
}

output "aws_private_subnet_id" {
  value = values(aws_subnet.private_subnets)[*].id
}

output "aws_database_subnet_id" {
  value = values(aws_subnet.database_subnets)[*].id
}