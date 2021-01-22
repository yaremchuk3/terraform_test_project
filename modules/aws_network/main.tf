data "aws_availability_zones" "myzone"{
  state = "available"
}

data "aws_elb_service_account" "main" {}

data "aws_caller_identity" "current" {}

locals {
  zones = data.aws_availability_zones.myzone.names
  bucket_name = "${var.s3bucket_for_elb.bucket_name}.${data.aws_caller_identity.current.account_id}"
}