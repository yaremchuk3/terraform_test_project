resource "aws_eip" "myIPsNatGW"{
  count = length(aws_subnet.privateSubnets[*].id)
  tags = merge(var.common_tags, {Name = "EIP_for_NatGW-${count.index}-${var.env}", Env = var.env})
}
