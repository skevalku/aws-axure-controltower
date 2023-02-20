/*terraform {
  backend "s3" {
    bucket = "terraform-petarskevalkutest-state"
    region = "eu-central-1"
    key    = "dc/s3/terraform.tfstate"
    dynamodb_table = "tf-locks"
 }
}
*/