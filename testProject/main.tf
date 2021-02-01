module "vpc" {
  source = "../modules/aws_network"

  env = "dev"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnet_cidr_blocks = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
  private_subnet_cidr_blocks = []
  elb_info = {
    "elb_enabled_access_logs" = "false"
    "elb_ingress_cidr" = ["0.0.0.0/0"]
    "elb_port" = ["80"]
    "elb_protocol" = "http"
  }
  common_tags = {
    "Owner" = "Alex Yaremchuk"
    "Project" = "testProject"
  }
}

module "lg_asg" {
  source = "../modules/launch_scalling_configuration"

  count = length(module.vpc.public_subnet_ids) > 0 ? 1 : 0
  env = module.vpc.env
  sg = module.vpc.sg_id
  subnet_ids = module.vpc.public_subnet_ids
  subnet_private_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
  elb = module.vpc.myELB_name
  common_tags = module.vpc.common_tags
  depends_on = [module.vpc]
}

