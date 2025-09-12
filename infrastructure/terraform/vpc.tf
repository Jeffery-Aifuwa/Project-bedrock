# VPC
resource "aws_vpc" "bedrock_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "bedrock-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "bedrock_igw" {
  vpc_id = aws_vpc.bedrock_vpc.id
  tags = {
    Name = "bedrock-igw"
  }
}

# Public Subnet A
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.bedrock_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name                                        = "bedrock-public-subnet-a"
    "kubernetes.io/cluster/bedrock-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

# Public Subnet B
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.bedrock_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true
  tags = {
    Name                                        = "bedrock-public-subnet-b"
    "kubernetes.io/cluster/bedrock-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.bedrock_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bedrock_igw.id
  }
  tags = {
    Name = "bedrock-public-rt"
  }
}

# Associate Public Subnet A with Public RT
resource "aws_route_table_association" "public_assoc_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Public Subnet B with Public RT
resource "aws_route_table_association" "public_assoc_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

# Private App Subnet
resource "aws_subnet" "app_subnet" {
  vpc_id            = aws_vpc.bedrock_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1a"  # Added AZ
  tags = {
    Name                                        = "bedrock-app-subnet"
    "kubernetes.io/cluster/bedrock-eks-cluster" = "owned"
    "kubernetes.io/role/internal-elb"          = "1"
  }
}

# Private DB Subnet
resource "aws_subnet" "db_subnet" {
  vpc_id            = aws_vpc.bedrock_vpc.id
  cidr_block        = "10.0.4.0/28"
  availability_zone = "eu-west-1b"  # Added AZ
  tags = {
    Name = "bedrock-db-subnet"
  }
}

# Private Route Tables (no NAT)
resource "aws_route_table" "app_rt" {
  vpc_id = aws_vpc.bedrock_vpc.id
  tags = {
    Name = "bedrock-app-rt"
  }
}

resource "aws_route_table_association" "app_assoc" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_rt.id
}

resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.bedrock_vpc.id
  tags = {
    Name = "bedrock-db-rt"
  }
}

resource "aws_route_table_association" "db_assoc" {
  subnet_id      = aws_subnet.db_subnet.id
  route_table_id = aws_route_table.db_rt.id
}
