resource "aws_nat_gateway" "myNatGW" {
  count = length(aws_subnet.privateSubnets[*].id)
  allocation_id = element(aws_eip.myIPsNatGW[*].id, count.index)
  subnet_id = element(aws_subnet.publicSubnets[*].id, count.index)
  depends_on = [aws_internet_gateway.myIGW]
  tags = merge(var.common_tags, {Name = "myNAT_GW-${count.index}-${var.env}", Env = var.env})
}

resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.myVpc.id
  tags = merge(var.common_tags, {Name = "myIGW-${var.env}", Env = var.env})
}