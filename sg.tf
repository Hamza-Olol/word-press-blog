module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "HO-sg"
  description = "Security group for the public word press serving EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = var.my-ip
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
  tags                = local.common_tags
}