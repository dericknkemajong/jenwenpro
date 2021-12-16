provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "glorykey"
    key    = "state/terraform.state"
    region = "us-east-1"
    dynamodb_table = "state-table"
  }
}