terraform {
  backend "s3" {
    bucket = "terraform-backend-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
    
  }
}


provider "aws" {
    region = "ap-south-1"
}

module "EC2" {
    source = "./modules/ec2"
  
}