resource "aws_vpc" "vpc2" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "Vpc2"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc2.id
  availability_zone       = "ap-south-1b"
  cidr_block              = "10.20.20.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnetvpc2"
  }
}

resource "aws_internet_gateway" "igw_vpc2" {
  vpc_id = aws_vpc.vpc2.id
  tags = {
    Name = "IGW-vpc2"
  }
}

resource "aws_route_table" "rt-vpc2" {
  vpc_id = aws_vpc.vpc2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc2.id
  }

  route {
    cidr_block = "10.10.0.0/16"
    gateway_id = aws_vpc_peering_connection.vpcperr.id
  }
}

resource "aws_route_table_association" "rt-assoc-vpc2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt-vpc2.id
}