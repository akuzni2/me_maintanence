provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "../../.aws/creds"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.tf_state_bucket

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}