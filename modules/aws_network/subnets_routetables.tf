resource "aws_subnet" "publicSubnets" {
  vpc_id = aws_vpc.myVpc.id
  count = length(var.public_subnet_cidr_blocks)
  availability_zone = element(local.zones, count.index)
  cidr_block = element(var.public_subnet_cidr_blocks, count.index)
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, {Name = "Public-Subnet-${count.index +1}-${var.env}", Env = var.env})
}

resource "aws_subnet" "privateSubnets" {
  vpc_id = aws_vpc.myVpc.id
  count = length(var.private_subnet_cidr_blocks)
  availability_zone = element(local.zones, count.index)
  cidr_block = element(var.private_subnet_cidr_blocks, count.index)
  tags = merge(var.common_tags, {Name = "Private-Subnet-${count.index +1}-${var.env}", Env = var.env})
}

resource "aws_route_table" "myRouteTablePublicSubnets" {
  count = length(aws_subnet.publicSubnets[*])
  vpc_id = aws_vpc.myVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIGW.id
  }
  tags = merge(var.common_tags, {Name = "RouteTablePublicSubnets-${var.env}", Env = var.env})
}

resource "aws_route_table" "myRouteTablePrivateSubnets" {
  count = length(aws_subnet.privateSubnets[*])
  vpc_id = aws_vpc.myVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.myNatGW[*].id, count.index)
  }
  tags = merge(var.common_tags, {Name = "RouteTablePrivateSubnets-${var.env}", Env = var.env})
}

resource "aws_route_table_association" "myPublicSubnets" {
  count = length(aws_subnet.publicSubnets[*].id)
  route_table_id = element(aws_route_table.myRouteTablePublicSubnets[*].id, count.index)
  subnet_id = element(aws_subnet.publicSubnets[*].id, count.index)
}
