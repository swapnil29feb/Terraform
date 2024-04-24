output "Public_IP" {
  value = aws_instance.day3_modular.public_ip
}

output "Ec2-id" {
  value = aws_instance.day3_modular.id
}