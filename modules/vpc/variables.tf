


# VPC attributes -----------------
variable "vpcname" {
  description = "Name to used on the VPC."
  type        = string
  default     = "SampleVpc"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

# Internet Access ----------------
variable "create_igw" {
  description = "Controls if an Internet Gateway is created."
  type        = bool
}

# Availability Zone attributes ---
variable "availability_zone" {
  description = "select AZ structure( 2az or 3az )"
  type        = string
  default     = "2az"
}

variable "az_id" {
  description = "specify AZ Ids"
  type        = list(string)
  default     = ["apne1-az4", "apne1-az1", "apne1-az2"] // for Tokyo Region
}

# VPC Flow Logs attributes -----
variable "vpcflowlogsbucket" {
  description = "S3 bucket ARN for VPC Flow Logs."
  type        = string
}