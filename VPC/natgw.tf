resource "aws_eip" "eip" {
  count  = var.nat_count
  vpc    = true  # Ensure the EIP is created in a VPC
}

resource "aws_nat_gateway" "ngw" {
  count         = var.nat_count
  subnet_id     = aws_subnet.public_subnet[count.index].id
  allocation_id = aws_eip.eip[count.index].id

  tags = {
    Name = "nat-gateway-${count.index + 1}"  # Example tag naming convention
  }
}