resource "aws_security_group" "sg_nodes" {
  name        = var.sg_name
  vpc_id      = var.sg_vpc_id

  tags = {
    Name = "AWS security group dynamic block"
  }
dynamic "ingress" {
    for_each = var.port_list
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


