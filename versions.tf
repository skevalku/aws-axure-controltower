terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
