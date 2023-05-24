module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.9.0"
  depends_on = [
    module.vpc,
    module.sg-db
  ]

  # RDS instance details
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 5
  identifier        = "ho-database-id"

  # RDS database details
  db_name = "testdb123"
  username          = "root"
  password          = "password"
  port     = "3306"

  # sg & subnet
  db_subnet_group_name = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [module.sg-db.security_group_id]
  subnet_ids = [module.vpc.database_subnets[0]]

  family = "mysql5.7"

  # RDS parameter group
  parameter_group_name = "ho-db-parameter-groupname"

  # DB option group
  major_engine_version = "5.7"

  multi_az = true
}

