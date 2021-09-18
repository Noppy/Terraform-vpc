

module "vpc" {
  source     = "../../modules/vpc"
  create_igw = true

  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}