resource "aws_instance" "new_ec2" {
  ami                    = "ami-05295b6e6c790593e"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tf-key.key_name
  vpc_security_group_ids = ["${aws_security_group.example.id}"]
  tags = {
    Name = "from_terraform"
  }
}

resource "aws_key_pair" "tf-key" {
  key_name   = "key-tf-deployer"
  public_key = file("${path.module}/keypair_terr.pub")
}

# output "keyname" {
#     value = "${aws_key_pair.tf-key.key_name}"
# }

# Creating Security group
resource "aws_security_group" "example" {
  name        = "allow-tls"
  description = "Allow SG for ec2"

  dynamic "ingress" {
    for_each = [22, 80, 443]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}