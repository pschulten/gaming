output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.gaming.id
}

output "eip" {
  value = aws_eip.default.public_ip
}
