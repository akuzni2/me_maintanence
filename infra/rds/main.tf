provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "creds"
}

terraform {
  required_version = ">= 1.0.10"
  backend "s3" {
    bucket = var.tf_state_bucket
    key = "me-maintenance/rds.tfstate"
    region = "us-east-1"
  }

}