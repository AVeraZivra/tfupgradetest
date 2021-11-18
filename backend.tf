terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.59"
    }

  }
  backend "s3" {
    bucket = "oldterraform-state"

    # dynamodb_table = "test_table", no need for this rn
    key    = "key"
    region = "us-east-2"
  }
}

