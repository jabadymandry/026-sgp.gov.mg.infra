resource "aws_subnet" "public_subnet" {
  cidr_block = "${var.subnet_prefix}.${var.public_subnet_index + count.index}.0/24"
  vpc_id = data.aws_vpc.vpc.id
  availability_zone = element(var.availability_zones, count.index)
  count = var.public_subnet_count

  tags = {
    "Name"      = "Public_subnet_${var.subnet_prefix}.${var.public_subnet_index + count.index}"
    "Projet"    = var.project_name
    "Author"    = var.author
  }
}

resource "aws_subnet" "private_subnet" {
  cidr_block = "${var.subnet_prefix}.${var.private_subnet_index + count.index}.0/24"
  vpc_id = data.aws_vpc.vpc.id
  availability_zone = element(var.availability_zones, count.index)
  count = var.private_subnet_count

  tags = {
    "Name"      = "Private_subnet_${var.subnet_prefix}.${var.private_subnet_index + count.index}"
    "Projet"    = var.project_name
    "Author"    = var.author
  }
}