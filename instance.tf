data "aws_region" "current" {}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  # Get the latest windows server ami
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base*"]
  }
}

resource "random_password" "password" {
  length  = 32
  special = true
}

resource "aws_ssm_parameter" "password" {
  name  = "${var.instance_name}-administrator-password"
  type  = "SecureString"
  value = random_password.password.result

  tags = local.tags
}


resource "aws_instance" "gaming" {
  ami = data.aws_ami.ami.id

#  user_data = templatefile("${path.module}/templates/user_data.tpl", {
#    password_ssm_parameter = aws_ssm_parameter.password.name,
#    var = {
#      instance_type = var.instance_type,
#    }
#  })

  key_name             = "pschu"
  ebs_optimized        = "true"
  instance_type        = var.instance_type
#  subnet_id            = module.vpc.private_subnets[1]
  subnet_id            = module.vpc.public_subnets[1]
  iam_instance_profile = aws_iam_instance_profile.gaming.id

  # Use provisioned IOPS storage to increase hard drive performance.
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = var.root_block_device_size_gb
    volume_type           = "gp3"
  }

  vpc_security_group_ids = [
    aws_security_group.gaming.id,
  ]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = local.tags
}

resource "aws_eip" "default" {
  instance = aws_instance.gaming.id
  vpc      = true
}
