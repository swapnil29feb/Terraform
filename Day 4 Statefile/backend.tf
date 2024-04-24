terraform {
  backend "s3" {
    bucket = "swapnil-s3-demo-tfstate"
    region = "ap-south-1"
    key = "swapnil/terraform.tfstate"
    dynamodb_table = "terraform-lock"
  }
}