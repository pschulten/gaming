data "terraform_remote_state" "base" {
  backend = "s3"

  config = {
    key      = "app-gaming/terraform.tfstate"
    bucket   = "pschu-tf-eu-west-1"
  }
}

resource "aws_ami_from_instance" "backup" {
  name               = "backup-${formatdate("YYYY-MM-DD", timestamp())}"
  source_instance_id = data.terraform_remote_state.base.outputs.instance_id
}

