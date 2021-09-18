####################################################
# Subnets( 2az or 3az )
####################################################
resource "aws_subnet" "publicsub1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, local.pubsub_newbits, local.pubsub_netnum_base)
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${var.vpcname}-publicsub1"
  }
}

resource "aws_subnet" "publicsub2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, local.pubsub_newbits, local.pubsub_netnum_base+1)
  availability_zone = "ap-northeast-1d"
  tags = {
    Name = "${var.vpcname}-publicsub2"
  }
}

resource "aws_subnet" "publicsub3" {
  count = var.availability_zone == "3az" ? 1 : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, local.pubsub_newbits, local.pubsub_netnum_base+2)
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "${var.vpcname}-publicsub3"
  }
}

resource "aws_subnet" "privatesub1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 2, 0)
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${var.vpcname}-privatesub1"
  }
}

resource "aws_subnet" "privatesub2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 2, 1)
  availability_zone = "ap-northeast-1d"
  tags = {
    Name = "${var.vpcname}-privatesub2"
  }
}

resource "aws_subnet" "privatesub3" {
  count = var.availability_zone == "3az" ? 1 : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 2, 2)
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "${var.vpcname}-privatesub3"
  }
}
