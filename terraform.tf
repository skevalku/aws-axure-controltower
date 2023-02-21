terraform {
  backend "s3" {
    bucket = "terraform-kingfisher-platform-skevalku-state"
    region = "eu-west-1"
    key    = "dc/s3/terraform.tfstate"
    dynamodb_table = "tf-locks"
 }
}


