terraform {
  required_version = ">=0.12.1"

  backend "s3" {
    bucket = "oldterraform-state"

    # dynamodb_table = "test_table", no need for this rn
    key    = "key"
    region = "us-east-2"
  }
}

