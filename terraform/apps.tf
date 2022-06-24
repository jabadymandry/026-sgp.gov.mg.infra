resource "aws_security_group" "sg_private" {
  description = "${var.project_name} ${var.environnement} private security group"
  vpc_id = data.aws_vpc.vpc.id
  dynamic "ingress"{
    for_each = var.sg_ingress_private
    content{
      from_port     = ingress.value.in_from_port
      to_port       = ingress.value.in_to_port
      protocol      = ingress.value.protocol
      cidr_blocks   = ingress.value.cidr_blocks
      description   = ingress.value.description
    }
  }

  dynamic "egress"{
    for_each = var.sg_egress_private
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

resource "aws_instance" "apps" {
  ami = var.ami
  instance_type = "t3.medium"
  iam_instance_profile = var.iam_profile
  key_name =  aws_key_pair.keyssh.key_name
  subnet_id = element(aws_subnet.private_subnet.*.id, 0)
  vpc_security_group_ids = [ aws_security_group.sg_private.id ]

  root_block_device {
    encrypted = true
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  tags = {
      Name          = "apps-${var.project_name}"
      environnement = "${var.environnement}"
      projet        = "${var.project_name}"
  }
}