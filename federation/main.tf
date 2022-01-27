terraform {
  required_version = ">= 1.0.8"

  backend "s3" {
    bucket         = "terraform-493994275831-us-east-1"
    key            = "mentoring_account/federation/github/oidc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-493994275831-us-east-1"
  }
}

module "variables" {
  source = "../variables/global"
}

provider "aws" {
  region = module.variables.aws_region

  # assume_role {
  #   role_arn = module.variables.aws_role
  # }
}

locals {
  tags = module.variables.tags
}


#################################################
## AWS Data
#################################################

# Get current region of Terraform stack
data "aws_region" "this" {}

# Get current account number
data "aws_caller_identity" "this" {}

# Retrieves the AWS partition of the execution
data "aws_partition" "this" {}