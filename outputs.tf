output "vpc" {
  value = aws_vpc.main.id
}

output "region" {
  value = "${var.region}      ${var.region_name}"
}

output "Public_subnets" {
  value = [
    "${aws_subnet.public1.id}         ${aws_subnet.public1.cidr_block}      ${aws_subnet.public1.availability_zone}",
    "${aws_subnet.public2.id}         ${aws_subnet.public2.cidr_block}      ${aws_subnet.public2.availability_zone}",
    "${aws_subnet.public3.id}         ${aws_subnet.public3.cidr_block}      ${aws_subnet.public3.availability_zone}",
  ]
}

output "Private_subnets" {
  value = [
    "${aws_subnet.private1.id}        ${aws_subnet.private1.cidr_block}     ${aws_subnet.private1.availability_zone}",
    "${aws_subnet.private2.id}        ${aws_subnet.private2.cidr_block}     ${aws_subnet.private2.availability_zone}",
    "${aws_subnet.private3.id}        ${aws_subnet.private3.cidr_block}     ${aws_subnet.private3.availability_zone}",
  ]
}

