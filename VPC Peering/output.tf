output "vpc_id" {
  description = "VPC id:"
  value       = aws_vpc.vpc1.id
}

output "webserver_subnet_ids" {
  description = "Webser Subnet CIDR"
  value       = aws_subnet.subnet1a.cidr_block
}

output "keyname" {
  description = "Keypair name"
  value       = aws_key_pair.key_pair_vpc.key_name
}

output "public_key" {
  description = "Public Ip of webserver EC2"
  value       = aws_instance.instance1.public_ip
}

output "vpcid" {
  description = "VPC-2"
  value       = aws_vpc.vpc2.id
}