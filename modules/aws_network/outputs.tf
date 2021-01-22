output "env" {
  value = var.env
}

output "available_zones" {
  value = data.aws_availability_zones.myzone[*].names
}

output "vpc_id" {
  value = aws_vpc.myVpc.id
}

output "sg_id" {
  value = aws_security_group.myDynamicSG.id
}

output "vpc_cecondary_cidr_block" {
  value = {
    for cidr in aws_vpc_ipv4_cidr_block_association.myVpcSecond_cidr:
          cidr.id => cidr.cidr_block
  }
}

output "public_subnet_ids" {
  value = aws_subnet.publicSubnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.privateSubnets[*].id
}

output "myIGW_id" {
  value = aws_internet_gateway.myIGW.id
}

output "myELB_dns_name" {
  value = aws_elb.myELB[*].dns_name
}

output "myELB_name" {
  value = aws_elb.myELB[*].name
}

output "EIP_id" {
  value = {
    for ip in aws_eip.myIPsNatGW:
        ip.id => ip.public_ip
  }
}

output "myNAT_GW" {
  value = {
    for gw in aws_nat_gateway.myNatGW:
        gw.id => gw.public_ip
  }
}

output "s3_bucket_id" {
  value = aws_s3_bucket.myS3bucket.id
}

output "common_tags" {
  value = var.common_tags
}