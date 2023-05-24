module "vpc" {
  #checkov:skip=CKV_AWS_111:IAM policy set on user account.
  #checkov:skip=CKV2_AWS_5:Security group is attached to the ec2 module
  #checkov:skip=CKV2_AWS_12:Default VPC is not in use
  #checkov:skip=CKV2_AWS_11:Skip adding flow logs for now
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "${local.name}-Vpc"
  cidr = var.cidr-range
  azs                  = var.azs
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Public subnets
  public_subnets       = var.public-subnet
  public_subnet_names = ["${local.name}-public-subnet-1", "${local.name}-public-subnet-2"]

  # Database subnets
  database_subnets                       = var.db-subnet
  create_database_subnet_group           = var.create_database_subnet_group
  create_database_subnet_route_table     = var.create_database_subnet_route_table
  create_database_nat_gateway_route      = var.create_database_nat_gateway_route 
  create_database_internet_gateway_route = var.create_database_internet_gateway_route
  database_subnet_names = ["${local.name}-testing-db-subnet-1", "${local.name}-testing-db-subnet-2"]
  database_subnet_group_tags  = local.common_tags

  tags = local.common_tags
}