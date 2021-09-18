#--vpc
output "vpc" {
  value = aws_vpc.this
}

#--subnet
output "publicsub1" {
  value = aws_subnet.publicsub1
}

output "publicsub2" {
  value = aws_subnet.publicsub2
}

output "publicsub3" {
  value = element(concat(aws_subnet.publicsub3.*, tolist([""])), 0)
}

output "privatesub1" {
  value = aws_subnet.privatesub1
}

output "privatesub2" {
  value = aws_subnet.privatesub2
}

output "privatesub3" {
  value = element(concat(aws_subnet.privatesub3.*, tolist([""])), 0)
}

