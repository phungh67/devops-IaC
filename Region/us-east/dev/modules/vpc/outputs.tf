output "main_vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "nat_gateway_ip" {
  value = aws_eip.nat_eip.public_ip
}

output "aws_public_subnet_id" {
  value = aws_subnet.public_subnets[*].id
}

output "aws_private_subnet_id" {
  value = aws_subnet.private_subnets[*].id
}

output "aws_database_subnet_id" {
  value = aws_subnet.database_subnets[*].id
}