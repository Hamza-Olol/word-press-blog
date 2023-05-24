module "ec2_instance" {
  #checkov:skip=CKV_AWS_88:Public IP is needed to access the wordpress blog via http/s
  #checkov:skip=CKV_AWS_8:EBS is not in use
  #checkov:skip=CKV_AWS_79:disabling the http end point does not allow the connection to the instances.
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"
  depends_on = [
    module.vpc,
    module.sg
  ]

  for_each = local.multiple_instances

  name = "${local.name}-instance-${each.key}"

  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = each.value.subnet_id
  user_data                   = file("serversetup.sh")
  associate_public_ip_address = true
  # metadata_options = {
  #   http_endpoint = "enabled"
  #   http_tokens   = "required"
  # }

  tags = local.common_tags
}
