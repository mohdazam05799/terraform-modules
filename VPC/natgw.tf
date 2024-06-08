
resource "aws_eip" "eip" {
  count  = var.nat_count
  domain = "vpc"

}

resource "aws_nat_gateway" "ngw" {
  count         = var.nat_count
  subnet_id     = aws_subnet.private_subnet[0].id
  allocation_id = aws_eip.eip[0].id

}