resource "aws_vpc" "sa-web-vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
 
  tags =merge(local.common_tags,{Name = "sa-vpc_basic-web"})
}

resource "aws_internet_gateway" "sa-web-igw" {
  vpc_id = aws_vpc.sa-web-vpc.id
  tags =merge(local.common_tags,{Name = sa-web-igw})
  }


resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.sa-web-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sa-web-igw.id
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.sa-web-vpc.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = var.map_public_ip_on_launch
  
  tags =merge(local.common_tags,{Name = "sa-public-subnet"})
}



  