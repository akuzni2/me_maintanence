provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "creds"
}

terraform {

  backend "s3" {
    bucket = "account-870029572904-tfstate"
    key = "me-maintenance/rds.tfstate"
    region = "us-east-1"
  }

}