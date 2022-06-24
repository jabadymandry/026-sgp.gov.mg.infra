resource "aws_eip" "sgp_eip" {
  vpc = true
  instance = aws_instance.front.id

  tags = {
    "Name"      = var.instance_name
    "Projet"    = var.project_name
    "Author"    = var.author
  }
}