terraform {
  required_version = ">= 1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 2"
    }
  }

  backend "s3" {
    bucket         = "pschu-tf-eu-west-1"
    key            = "app-gaming/terraform.tfstate"
    dynamodb_table = "pschu-tf"
    region         = "eu-west-1"
    encrypt        = "true"
  }
}
