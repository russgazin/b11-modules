resource "aws_security_group" "sg" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_tag
  }
}

resource "aws_security_group_rule" "my_rule" {
  description              = var.sg_description
  type                     = var.type
  from_port                = var.from_port
  to_port                  = var.to_port
  protocol                 = var.protocol
  cidr_blocks              = length(var.cidr_blocks) <= 18 ? var.cidr_blocks : null
  source_security_group_id = startswith(var.source_security_group_id, "sg-") ? var.source_security_group_id : null
  security_group_id        = aws_security_group.sg.id
}

