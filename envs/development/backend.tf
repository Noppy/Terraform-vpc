terraform {
  backend "s3" {
    bucket = "nobuyuf-tforg-test01-tfstate-bucket"
    key    = "vpctest/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
