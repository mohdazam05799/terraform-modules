
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.public_subnet ? (var.public_subnet_count > 0 ? var.public_subnet_count : 2) : 0
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
  tags                    = merge(local.common_tags, tomap({ "Name" : "${var.project}-${var.env}-public-subnet-${count.index + 1}" }))
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.private_subnet ? (var.private_subnet_count > 0 ? var.private_subnet_count : 2) : 0
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, (length(aws_subnet.public_subnet) + count.index))
  map_public_ip_on_launch = false
  tags                    = merge(local.common_tags, tomap({ "Name" : "${var.project}-${var.env}-private-subnet-${count.index + 1}" }))
}


resource "aws_subnet" "db_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.db_subnet ? (var.db_subnet_count > 0 ? var.db_subnet_count : 2) : 0
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, (length(aws_subnet.public_subnet) + length(aws_subnet.private_subnet) + count.index))
  map_public_ip_on_launch = false
  tags                    = merge(local.common_tags, tomap({ "Name" : "${var.project}-${var.env}-db-subnet-${count.index + 1}" }))
}
