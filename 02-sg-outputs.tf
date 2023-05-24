# Public EC2 sg
output "public_security_group_id" {
  value = module.sg.security_group_id
}

output "public_security_group_vpc_id" {
  value = module.sg.security_group_vpc_id
}

# Private database sg
output "Database_security_group_id" {
  value = module.sg-db.security_group_id
}

output "Database_security_group_vpc_id" {
  value = module.sg-db.security_group_vpc_id
}