

module "vpc-3az" {
  source = "../../modules/vpc"

  vpcname                        = "3azVpc"
  vpc_cidr_block                 = "10.1.3.0/24"
  availability_zone              = "3az" // "2az" or "3az"
  create_igw                     = true
  create_nagtw                   = true
  sg_ec2_ssh_ingress_source_cidr = "27.0.0.0/8"

  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}

module "vpc-2az" {
  source = "../../modules/vpc"

  vpcname                        = "2azVpc"
  vpc_cidr_block                 = "10.1.2.0/24"
  availability_zone              = "2az" // "2az" or "3az"
  create_igw                     = true
  create_nagtw                   = true
  sg_ec2_ssh_ingress_source_cidr = "27.0.0.0/8"

  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}

module "private-vpc-3az" {
  source = "../../modules/vpc"

  vpcname           = "private-3azVpc"
  vpc_cidr_block    = "10.99.3.0/24"
  availability_zone = "3az" // "2az" or "3az"
  create_igw        = false
  create_nagtw      = false

  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}

module "private-vpc-2az" {
  source = "../../modules/vpc"

  vpcname           = "private-2azVpc"
  vpc_cidr_block    = "10.99.2.0/24"
  availability_zone = "2az" // "2az" or "3az"
  create_igw        = false
  create_nagtw      = false

  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}