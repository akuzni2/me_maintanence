provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "../../.aws/creds"
}

terraform {
  required_version = ">= 1.0.10"
  backend "s3" {
    bucket = var.tf_state_bucket
    key    = "me-maintenance/reminder-lambda.tfstate"
    region = "us-east-1"
  }

}