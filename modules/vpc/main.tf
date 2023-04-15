data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = var.instance_tenancy_type
  enable_dns_hostnames = var.is_dns_hostname_enable

  tags = {
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.20.${10+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "private-subnet-${count.index}"
    Environment = var.environment
  }
}

resource "aws_subnet" "public_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.20.${10+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name = "public-subnet-${count.index}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "nat_gw" {
  subnet_id         = aws_subnet.public_subnet[0].id
  tags = {
    Name = "nat-gw-vpc"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
    Environment = var.environment
  }
}
