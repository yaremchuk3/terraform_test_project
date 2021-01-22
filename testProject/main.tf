module "vpc" {
  source = "../modules/aws_network"

  env = "dev"
  vpc_cidr_block = "192.168.0.0/16"
  public_subnet_cidr_blocks = [
    "192.168.100.0/24",
    "192.168.200.0/24",
    "192.168.0.0/24"
  ]
  elb_info = {
    "elb_enabled_access_logs" = "false"
    "elb_ingress_cidr" = ["0.0.0.0/0"]
    "elb_port" = "80"
    "elb_protocol" = "http"
  }
  common_tags = {
    "Owner" = "Alex Yaremchuk"
    "Project" = "testProject"
  }
}

module "lg_asg" {
  source = "../modules/launch_configuration"

  count = length(module.vpc.public_subnet_ids) > 0 ? 1 : 0
  env = module.vpc.env
  sg = module.vpc.sg_id
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id = module.vpc.vpc_id
  elb = module.vpc.myELB_name
  common_tags = module.vpc.common_tags

  depends_on = [module.vpc]
}
