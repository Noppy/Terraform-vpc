resource "aws_flow_log" "main" {
  log_destination      = var.vpcflowlogsbucket
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
  tags = {
    Name = "${var.vpcname}-vpc-flow-log"
  }
}