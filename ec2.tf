module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  depends_on = [
    module.vpc,
    module.sg
  ]
  name = "HO-Wordpress-instance"

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  #   monitoring             = true
  vpc_security_group_ids = module.sg.security_group_id
  # subnet_id              = "module.vpc.public_subnets"
  subnet_id              = var.public-subnet
  user_data              = file("serversetup.sh")

  tags = local.common_tags
}