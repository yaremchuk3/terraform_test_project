variable "region" {
  default = "eu-central-1"
}
variable "env" {
  default = "dev"
}
variable "common_tags" {
  default = {
    "Owner" = "Alex"
    "Project" = "TestProject"
  }
}
variable "sg_open_ports" {
  default = ["80"]
}
variable "sg_open_protocol" {
  default = "tcp"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_additional_cidr_block" {
  default = [
  ]
}

variable "public_subnet_cidr_blocks" {
  default = [
    "10.0.0.0/24",
  ]
}

variable "private_subnet_cidr_blocks" {
  default = [
  ]
}

variable "backend_port" {
  default = {
    "port" = "80"
    "protocol" = "http"
  }
}

variable "elb_info" {
  default = {
    "elb_port" = ["80"]
    "elb_protocol" = "http"
    "elb_ingress_cidr" = ["0.0.0.0/0"]
    "elb_enabled_access_logs" = "true"
  }
}

variable "s3bucket_for_elb" {
  default = {
    "bucket_name" = "elbaccesslogs"
  }
}

variable "elb_health_check" {
  default = {
    "healthy_threshold" = "2"
    "interval" = "10"
    "target" = "http:80/"
    "timeout" = "5"
    "unhealthy_threshold" = "2"
  }
}