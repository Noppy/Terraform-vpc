resource "aws_flow_log" "this" {
  log_destination      = var.vpcflowlogsbucket
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this.id
  tags = {
    Name = "${var.vpcname}-vpc-flow-log"
  }
}