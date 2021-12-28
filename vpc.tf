data "aws_availability_zones" "x" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.11.0"

  name = "gaming"
  cidr = "10.1.0.0/16"

  azs             = data.aws_availability_zones.x.names
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  enable_ipv6        = true

  tags = local.tags
}
