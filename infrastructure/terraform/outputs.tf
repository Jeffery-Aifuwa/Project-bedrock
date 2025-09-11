output "vpc_id" {
  value = aws_vpc.bedrock_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
}

output "app_subnet_id" {
  value = aws_subnet.app_subnet.id
}

output "db_subnet_id" {
  value = aws_subnet.db_subnet.id
}

