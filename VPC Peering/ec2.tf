resource "aws_key_pair" "key_pair_vpc" {
  key_name   = "vpc_keypair"
  public_key = file("${path.module}/vpcperring.pub")
}


resource "aws_security_group" "sg-myproject1" {
  name        = "allow-all"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.vpc1.id

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

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.20.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSecurityGroup1"
  }
}

resource "aws_instance" "instance1" {
  ami                    = "ami-007020fd9c84e18c7"
  key_name               = aws_key_pair.key_pair_vpc.key_name
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet1a.id
  vpc_security_group_ids = [aws_security_group.sg-myproject1.id]
  tags = {
    Name = "vpc1_perr"
  }
}

#******************************************************************

resource "aws_security_group" "sg-myproject2" {
  vpc_id = aws_vpc.vpc2.id

  dynamic "ingress" {
    for_each = [20, 80, 443]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AllowSecurityGroup2"
  }
}

resource "aws_instance" "instance2" {
  ami                    = "ami-007020fd9c84e18c7"
  key_name               = aws_key_pair.key_pair_vpc.key_name
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg-myproject2.id]
  tags = {
    Name = "vpc2_perr"
  }
}