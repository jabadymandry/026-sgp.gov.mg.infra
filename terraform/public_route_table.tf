resource "aws_route_table_association" "public_subnets" {
  count = var.public_subnet_count
  route_table_id = var.route_table
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
}
