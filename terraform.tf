terraform {
  backend "s3" {
    bucket = "terraform-skevalku-state-123"
    region = "eu-central-1"
    key    = "dc/s3/terraform.tfstate"
    dynamodb_table = "tf-locks"
 }
}
