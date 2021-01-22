resource "aws_autoscaling_group" "asg" {
  count = length(var.subnet_ids) > 0 ? 1 : 0
  name = "ASG"
  max_size = 4
  min_size = 3
  desired_capacity = 2
  launch_configuration = aws_launch_configuration.launch_conf.id
  load_balancers = var.elb
  vpc_zone_identifier = var.subnet_ids
  depends_on = [aws_launch_configuration.launch_conf]

  dynamic "tag" {
    for_each = var.common_tags
    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }

  tag {
    key = "Env"
    propagate_at_launch = true
    value = var.env
  }

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "TestServer-${count.index +1}-${var.env}"
  }
 }