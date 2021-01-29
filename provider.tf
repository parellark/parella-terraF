terraform {
  required_version = ">= 0.12.26"
  #backend "s3" {
   # bucket = "terraform-demo-eks"
    #key    = "eks-terraform.tfstate"
    #region = "ap-south-1"
  #}
}

provider "aws" {
  region = "ap-south-1"
  #shared_credentials_file = var.shared_credentials_file_url
  # profile                 = "default"
  access_key = var.access_key
  secret_key = var.secret_key
}
