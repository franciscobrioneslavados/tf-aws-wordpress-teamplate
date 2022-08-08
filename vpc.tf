# Create the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name        = "${lower(var.app_name)}-${lower(var.app_environment)}-vpc"
    Environment = var.app_environment
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${lower(var.app_name)}-${lower(var.app_environment)}-igw"
    Environment = var.app_environment
  }
}

# Define the public subnet
resource "aws_subnet" "public_subnet" {
  count             = var.subnet_count.public
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.availabe.names[count.index]
  tags = {
    Name        = "${lower(var.app_name)}-${lower(var.app_environment)}-public-subnet_${count.index}"
    Environment = var.app_environment
  }
}

# Define the public subnet
resource "aws_subnet" "private_subnet" {
  count             = var.subnet_count.private
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.availabe.names[count.index]
  tags = {
    Name        = "${lower(var.app_name)}-${lower(var.app_environment)}-private-subnet_${count.index}"
    Environment = var.app_environment
  }
}



# Define the public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name        = "${lower(var.app_name)}-${lower(var.app_environment)}-public-subnet-rt"
    Environment = var.app_environment
  }
}

# Define the public route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${lower(var.app_name)}_${lower(var.app_environment)}_private_subnet_rt"
    Environment = var.app_environment
  }
}

# Assign the public route table to the public subnet
resource "aws_route_table_association" "public_rt_association" {
  count          = var.subnet_count.public
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

# Assign the public route table to the public subnet
resource "aws_route_table_association" "private_rt_association" {
  count          = var.subnet_count.private
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}
