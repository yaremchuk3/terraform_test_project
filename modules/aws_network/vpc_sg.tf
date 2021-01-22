resource "aws_vpc" "myVpc" {
  cidr_block = var.vpc_cidr_block
  tags = merge(var.common_tags, {Name = "myVpc-${var.env}", Env = var.env})
}

resource "aws_vpc_ipv4_cidr_block_association" "myVpcSecond_cidr" {
  count = length(var.vpc_additional_cidr_block)
  cidr_block = element(var.vpc_additional_cidr_block, count.index)
  vpc_id = aws_vpc.myVpc.id
}

resource "aws_security_group" "myDynamicSG" {
  name_prefix = "${var.env}-SGDynamic-"
  vpc_id = aws_vpc.myVpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.sg_open_ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = var.sg_open_protocol
      cidr_blocks = var.elb_info.elb_ingress_cidr
    }
  }

  tags = merge(var.common_tags, {Name = "myDynamicSG-${var.env}", Env = var.env})
}
