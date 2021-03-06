variable "env" {
  default = "dev"
}

variable "linux_name" {
  default = "amazon2"
}

variable "instance_type" {
  default = {
    "dev" = "t2.micro"
    "stag" = "t2.small"
    "prod" = "t2.medium"
  }
}

variable "lc_name" {
  default = "launch_config"
}

variable "lc_name_private" {
  default = "launch_config_private"
}

variable "sg" {}
variable "subnet_ids" {}
variable "subnet_private_ids" {}
variable "vpc_id" {}
variable "common_tags" {
  default = {
    "Owner" = "Alex"
    "Project" = "TestProject"
  }
}

variable "elb" {}
