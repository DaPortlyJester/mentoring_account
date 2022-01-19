terraform {
  required_version = ">= 1.0.8"

  backend "s3" {
    bucket         = "terraform-493994275831-us-east-1"
    key            = "mentoring_account/persistence/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-493994275831-us-east-1"
  }
}

module "variables" {
  source = "../../variables/global"
}

provider "aws" {
  region = module.variables.aws_region

  # assume_role {
  #   role_arn = module.variables.aws_role
  # }
}

#################################################
## AWS Data
#################################################

# Get current region of Terraform stack
data "aws_region" "this" {}

# Get current account number
data "aws_caller_identity" "this" {}

variable "terraform_bucket_prefix" {
  description = "Prefix for terraform bucket name"
  default     = "terraform"
}

data "aws_iam_policy_document" "terraform" {
  statement {
    sid = "DeployerGetsFullAccess"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::493994275831:user/broadwells"
      ]
    }

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${var.terraform_bucket_prefix}-${data.aws_caller_identity.this.account_id}-${data.aws_region.this.name}",
      "arn:aws:s3:::${var.terraform_bucket_prefix}-${data.aws_caller_identity.this.account_id}-${data.aws_region.this.name}/*"
    ]
  }
}

resource "aws_s3_bucket" "terraform" {
  bucket = "${var.terraform_bucket_prefix}-${data.aws_caller_identity.this.account_id}-${data.aws_region.this.name}"
  acl    = "private"
  policy = data.aws_iam_policy_document.terraform.json

  # lifecycle {
  #   prevent_destroy = true
  # }

  # logging {
  #   target_bucket = aws_s3_bucket.log_bucket.id
  #   target_prefix = "${var.terraform_bucket_prefix}-${data.aws_caller_identity.this.account_id}-${data.aws_region.this.name}/"
  # }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = module.variables.tags

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket                  = aws_s3_bucket.terraform.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#################################################
## Terraform DynamoDB Table
#################################################

resource "aws_dynamodb_table" "terraform" {
  name         = aws_s3_bucket.terraform.id
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  tags = merge(module.variables.tags, {
    Name : "terraform-dynamo-db"
  })

  # lifecycle {
  #   prevent_destroy = true
  # }
}