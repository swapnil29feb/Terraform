provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "swapnil_inst" {
  ami = "ami-007020fd9c84e18c7"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "swapnil-tfstate" {
  bucket = "swapnil-s3-demo-tfstate"
}

resource "aws_dynamodb_table" "state_lock" {
    name = "terraform-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
}