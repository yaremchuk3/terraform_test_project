data "aws_ami" "amazon2_linux" {
  owners = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
data "aws_availability_zones" "myzone"{
  state = "available"
}