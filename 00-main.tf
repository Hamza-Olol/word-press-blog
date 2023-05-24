terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    region = "eu-north-1"
    bucket = "ho-wordpressblog"
    key    = "terraform.tfstate"
    ## for state locking, use dynamodb 
    # dynamodb_table = "------"
    # encrypt        = "true"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
