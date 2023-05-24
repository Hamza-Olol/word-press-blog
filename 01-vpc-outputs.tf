output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

# Added db subnets & route tables as an output
output "database_subnets" {
  value = module.vpc.database_subnets
}

output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group_name
}

output "database_route_table_ids" {
  value = module.vpc.database_route_table_ids
}

