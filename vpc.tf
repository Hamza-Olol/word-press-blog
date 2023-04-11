# need subnets
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "HO-vpc"
  cidr = var.cidr-range

  azs            = var.azs
  public_subnets = [var.public-subnet]

  tags = local.common_tags
}