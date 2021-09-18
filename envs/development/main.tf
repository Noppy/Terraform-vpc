

module "vpc" {
  source = "../../modules/vpc"

  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}