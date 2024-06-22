output "vpc_id" {
    description = "VPC ID"
    value       = aws_vpc.my_vpc.id
}

output "subnet_ids" {
    description = "Subnet IDs"
    value       = aws_subnet.subnets.*.id
}