variable "author" {
  type = string
}

variable "profile" {
  description = "Profile de connexion au cloud"
  type = string
}

variable "region" {
  description = "Region de deploiement"
  type = string
}

variable "subnet_prefix" {
  type = string
  description = "Prefix subnet derive de VPC subnet"
}

variable "public_subnet_index" {
  type = number
}

variable "private_subnet_index" {
  type = number
}

variable "public_subnet_count" {
  description = "Count of subnets to create"
  type = number
  default = 1
}

variable "private_subnet_count" {
  description = "Count of subnets to create"
  type = number
  default = 1
}

variable "availability_zones" {
  description = "List of avaibility zones to use"
  type = list(string)
}

variable "instance_name" {
  description = "Instance name"
  type = string
}

variable "project_name" {
  description = "Project name"
  type = string
}

variable "environnement" {
  description = "Environnement"
  type = string
}

variable "sg_ingress_public" {
  description = "Ingress rule parameters"
  type = map(object({
    in_from_port    = number,
    in_to_port      = number,
    protocol        = string,
    cidr_blocks     = list(string),
    description     = string
  }))
}

variable "sg_egress_public" {
  description = "Egress rule parameters"
  type = map(object({
    e_from_port     = number,
    e_to_port       = number,
    protocol      = string,
    cidr_blocks     = list(string),
    description     = string
  }))
}

variable "sg_ingress_private" {
  description = "Ingress rule parameters"
  type = map(object({
    in_from_port    = number,
    in_to_port      = number,
    protocol        = string,
    cidr_blocks     = list(string),
    description     = string
  }))
}

variable "sg_egress_private" {
  description = "Egress rule parameters"
  type = map(object({
    e_from_port     = number,
    e_to_port       = number,
    protocol      = string,
    cidr_blocks     = list(string),
    description     = string
  }))
}

variable "ami" {
  description = "AMI to use"
  type = string
}

variable "instance_type" {
  description = "Instance type to used: t3.micro, t3.medium, etc"
  type = string
}

variable "iam_profile" {
  description = "IAM profile to attribute role to EC2 instance"
  type = string
}

variable "volume_type" {
  description = "Volume type"
  type = string
  default = "gp2"
}

variable "volume_size" {
  description = "Volume size"
  type = string
  default = "30"
}

variable "route_table" {
  type = string
}

// RDS
variable "engine"{}
variable "engine_version" {}
variable "family" {}
variable "major_engine_version" {}
variable "instance_class" {}
variable "db_port" {}
variable "db" {}
variable "dbuser" {}
variable "dbpass" {}