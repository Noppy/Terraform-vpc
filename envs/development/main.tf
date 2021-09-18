

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr_block    = "10.1.1.0/24"
  availability_zone = "3az" // "2az" or "3az"
  create_igw        = true
  create_nagtw      = true


  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}