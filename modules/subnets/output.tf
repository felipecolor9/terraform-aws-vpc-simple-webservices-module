output "private_subnet_ids" {
  description = "List of ID on the private subnet"
  value       = aws_subnet.private_subnet.*.id
}

output "public_subnet_ids" {
  description = "List of ID on the public subnet"
  value       = aws_subnet.public_subnet.*.id
}