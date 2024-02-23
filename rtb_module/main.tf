resource "aws_route_table" "rtb" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = var.gateway_id == null ? null : var.gateway_id
    nat_gateway_id = var.nat_gateway_id == null ? null : var.nat_gateway_id
  }

  tags = {
    Name = "${var.gateway_id == null ? "private" : "public"}_rtb"
  }
}

resource "aws_route_table_association" "assoc" {
  count          = length(var.subnets)
  subnet_id      = var.subnets[count.index]
  route_table_id = aws_route_table.rtb.id
}
