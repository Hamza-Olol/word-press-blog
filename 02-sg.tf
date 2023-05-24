module "sg" {
  #checkov:skip=CKV2_AWS_5:Security group is attached to the ec2 module
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "${local.name}-Sg"
  description = "Security group for the public word press serving EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = var.my-ip
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
  tags                = local.common_tags
}

module "sg-db" {
  #checkov:skip=CKV2_AWS_5:Security group is attached to the RDS module
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "${local.name}-Sg-db"
  description = "Security group for the RDS database"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = var.internal-cidr
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
  tags                = local.common_tags
}