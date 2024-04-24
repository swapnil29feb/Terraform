resource "aws_vpc" "vpc1" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "VPC_1"
  }
}

resource "aws_subnet" "subnet1a" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet1"
  }
}

resource "aws_internet_gateway" "igw_vpc1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "igw-vpc1"
  }
}

resource "aws_route_table" "rt_vpc1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc1.id
  }

  route {
    cidr_block = "10.20.0.0/16"
    gateway_id = aws_vpc_peering_connection.vpcperr.id
  }
}

resource "aws_route_table_association" "rt-ass-vpc1" {
  subnet_id      = aws_subnet.subnet1a.id
  route_table_id = aws_route_table.rt_vpc1.id
}

resource "aws_vpc_peering_connection" "vpcperr" {
  vpc_id      = aws_vpc.vpc1.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true

  tags = {
    Name = "VPC Peering"
  }
}