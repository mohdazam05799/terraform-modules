resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  count  = var.public_subnet ? 1 : 0
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  depends_on = [aws_internet_gateway.igw]
  tags       = merge(local.common_tags, tomap({ "Name" : "${var.project}-${var.env}-public-route-table" }))
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  count  = (var.db_subnet || var.private_subnet) ? 1 : 0
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  tags = merge(local.common_tags, tomap({ "Name" : "${var.project}-${var.env}-private-route-table" }))

}

resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.vpc.id
  count  = (var.db_subnet || var.private_subnet) ? 1 : 0
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  tags = merge(local.common_tags, tomap({ "Name" : "${var.project}-${var.env}-db-route-table" }))

}


resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt[0].id

}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[0].id

}

resource "aws_route_table_association" "db-public_rt_association" {
  count          = length(aws_subnet.db_subnet)
  route_table_id = aws_route_table.db_rt[0].id
  subnet_id      = aws_subnet.db_subnet[count.index].id

}

resource "aws_route" "route" {
  nat_gateway_id         = aws_nat_gateway.ngw[0].id
  route_table_id         = aws_route_table.private_rt[0].id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_nat_gateway.ngw]
}