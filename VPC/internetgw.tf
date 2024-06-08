resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.vpc.id
  tags       = merge(local.common_tags, tomap({ "Name" : "${var.project}-${var.env}-internet-gateway" }))
  depends_on = [aws_vpc.vpc]

}

# resource "aws_internet_gateway_attachment" "igw_attachment" {
#     vpc_id = aws_vpc.vpc.id
#     internet_gateway_id = aws_internet_gateway.igw.id
#     depends_on = [ aws_internet_gateway.igw ]

# }