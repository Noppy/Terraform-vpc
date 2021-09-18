

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr_block    = "10.1.1.0/24"
  availability_zone = "2az" // "2az" or "3az"
  create_igw        = true


  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}