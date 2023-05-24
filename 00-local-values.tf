locals {
  initials   = "HO"
  capability = "PE"
  project    = "Wordpress"
  name       = "${local.initials}-${local.capability}-${local.project}"
  common_tags = {
    name       = local.initials
    capability = local.capability
    project    = local.project
  }

  multiple_instances = {
    one = {
      subnet_id = element(module.vpc.public_subnets, 0)
    }
    two = {
      subnet_id = element(module.vpc.public_subnets, 1)
    }
  }
}