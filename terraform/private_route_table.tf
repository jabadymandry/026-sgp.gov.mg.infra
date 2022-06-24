// Static IP for Nat Gateway
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name   = "eip-nat_${var.project_name}"
    Author = var.author
  }
}

// Nat Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)

  tags = {
    Name   = "nat_${var.project_name}"
    Author = var.author
  }
}

// Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name   = "private_rt_${var.project_name}"
    Author = var.author
  }
}

// Associate private subnets to private route table
resource "aws_route_table_association" "private" {
  count          = var.private_subnet_count
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}