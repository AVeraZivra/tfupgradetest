terraform {
  required_version = "0.11.14"

  backend "s3" {
    bucket = "oldterraform-state"

    # dynamodb_table = "test_table", no need for this rn
    key    = "key"
    region = "us-east-2"
  }
}
