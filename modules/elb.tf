resource "aws_elb" "myELB" {
  count = length(var.public_subnet_cidr_blocks) != 0 ? 1 : 0
  name = "${var.env}-Elb"
  security_groups = [aws_security_group.myDynamicSG.id]
  subnets = aws_subnet.publicSubnets[*].id
  listener {
    instance_port = var.backend_port.port
    instance_protocol = var.backend_port.protocol
    lb_port = var.elb_info.elb_port
    lb_protocol = var.elb_info.elb_protocol
  }
  access_logs {
    enabled = var.elb_info.elb_enabled_access_logs
    bucket = aws_s3_bucket.myS3bucket.id
  }
  health_check {
    healthy_threshold = var.elb_health_check.healthy_threshold
    interval = var.elb_health_check.interval
    target = var.elb_health_check.target
    timeout = var.elb_health_check.timeout
    unhealthy_threshold = var.elb_health_check.unhealthy_threshold
  }
  depends_on = [
    aws_internet_gateway.myIGW,
    aws_s3_bucket.myS3bucket,
    aws_s3_bucket_policy.elb_access_to_s3_bucket
  ]
  tags = merge(var.common_tags, {Name = "myELB-${var.env}", Env = var.env})
}