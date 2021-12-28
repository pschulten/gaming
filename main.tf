locals {
  tags = merge(var.additional_tags, {
    Name = var.instance_name
  })
}
