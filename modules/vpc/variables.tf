


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

variable "create_nagtw" {
  description = "Controls if NAT Gateway(s) are created."
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

# DHCP Option set ----------------
variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided."
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  description = "Specify a list of NTP servers for DHCP options set, default to Amazon Time Sync Service"
  type        = list(string)
  default     = ["169.254.169.123"]
}

# VPC Flow Logs attributes -----
variable "vpcflowlogsbucket" {
  description = "S3 bucket ARN for VPC Flow Logs."
  type        = string
}