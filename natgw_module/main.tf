resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id = var.subnet_id
  tags = {
    Name = var.natgw_tag
  }
}