resource "aws_key_pair" "keyssh" {
  key_name = "${var.project_name}"
  public_key = file("keys/${var.project_name}.pub")

  tags = {
      environnement = "${var.environnement}"
      projet        = "${var.project_name}"
  }
}

resource "aws_security_group" "sg_public" {
  description = "${var.project_name} ${var.environnement} public security group"
  vpc_id = data.aws_vpc.vpc.id
  dynamic "ingress"{
    for_each = var.sg_ingress_public
    content{
      from_port     = ingress.value.in_from_port
      to_port       = ingress.value.in_to_port
      protocol      = ingress.value.protocol
      cidr_blocks   = ingress.value.cidr_blocks
      description   = ingress.value.description
    }
  }

  dynamic "egress"{
    for_each = var.sg_egress_public
    content{
      from_port     = egress.value.e_from_port
      to_port       = egress.value.e_to_port
      protocol      = egress.value.protocol
      cidr_blocks   = egress.value.cidr_blocks
      description   = egress.value.description
    }
  }

  tags = {
      environnement = "${var.environnement}"
      projet        = "${var.project_name}"
  }
}

resource "aws_instance" "front" {
  ami = var.ami
  instance_type = "t3.small"
  iam_instance_profile = var.iam_profile
  key_name =  aws_key_pair.keyssh.key_name
  subnet_id = element(aws_subnet.public_subnet.*.id, 0)
  vpc_security_group_ids = [ aws_security_group.sg_public.id ]

  root_block_device {
    encrypted = true
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  tags = {
      Name          = "front-${var.project_name}"
      environnement = "${var.environnement}"
      projet        = "${var.project_name}"
  }
}