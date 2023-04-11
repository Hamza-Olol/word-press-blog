locals {
  initials   = "HO"
  capability = "PE"
  common_tags = {
    name       = local.initials
    capability = local.capability
  }
}