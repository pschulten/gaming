data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  ip_cidr_block = ["${chomp(data.http.my_ip.body)}/32"]
}

resource "aws_security_group" "gaming" {
  name        = "gaming"
  description = "allow gaming ingress and egress"
  vpc_id      = module.vpc.vpc_id

  tags = local.tags
}

# Allow rdp connections from the local ip
resource "aws_security_group_rule" "rdp_ingress" {
  type              = "ingress"
  description       = "Allow rdp connections (port 3389)"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = local.ip_cidr_block
  security_group_id = aws_security_group.gaming.id
}

# Allow vnc connections from the local ip
resource "aws_security_group_rule" "vnc_ingress" {
  type              = "ingress"
  description       = "Allow vnc connections (port 5900)"
  from_port         = 5900
  to_port           = 5900
  protocol          = "tcp"
  cidr_blocks       = local.ip_cidr_block
  security_group_id = aws_security_group.gaming.id
}

# Allow dcv connections from the local ip
resource "aws_security_group_rule" "dcv_ingress" {
  type              = "ingress"
  description       = "Allow dcv connections (port 8443)"
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  cidr_blocks       = local.ip_cidr_block
  security_group_id = aws_security_group.gaming.id
}

# Allow sunshine UI connections from the local ip
resource "aws_security_group_rule" "sunshine_ingress" {
  type              = "ingress"
  description       = "Allow moonlight connections (port 47990)"
  from_port         = 47990
  to_port           = 47990
  protocol          = "tcp"
  cidr_blocks       = local.ip_cidr_block
  security_group_id = aws_security_group.gaming.id
}

# Allow moonlight client connections from the local ip
resource "aws_security_group_rule" "moonlight_ingress" {
  type              = "ingress"
  description       = "Allow moonlight client connections"
  from_port         = 47984
  to_port           = 48010
  protocol          = "tcp"
  cidr_blocks       = local.ip_cidr_block
  security_group_id = aws_security_group.gaming.id
}

# Allow moonlight client connections from the local ip
resource "aws_security_group_rule" "moonlight_udp_ingress" {
  type              = "ingress"
  description       = "Allow moonlight client udp connections"
  from_port         = 47998
  to_port           = 48010
  protocol          = "udp"
  cidr_blocks       = local.ip_cidr_block
  security_group_id = aws_security_group.gaming.id
}


# Allow outbound connection to everywhere
resource "aws_security_group_rule" "default" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gaming.id
}
