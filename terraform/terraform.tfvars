author          = "Bruno Enée"
profile         = "PRODIGY"
region          = "ap-south-1"
subnet_prefix   = "10.5"
public_subnet_index = 5
public_subnet_count = 1
private_subnet_index = 6
private_subnet_count = 2
availability_zones = [ "ap-south-1a", "ap-south-1b" ]
instance_name = "sgp"
environnement = "recette"
# REGLE SG PUBLIC
sg_ingress_public = {
  "1" = {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "HTTP IN"
    in_from_port = 80
    in_to_port = 80
    protocol = "tcp"
  },
  "2" = {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "HTTPS IN"
    in_from_port = 443
    in_to_port = 443
    protocol = "tcp"
  },
  "3" = {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "SSH IN"
    in_from_port = 22
    in_to_port = 22
    protocol = "tcp"
  },
  "4" = {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "ICMP IN"
    in_from_port = 0
    protocol = "icmp"
    in_to_port = 0
  }
}

sg_egress_public = {
  "1" = {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "HTTP OUT"
    e_from_port = 80
    protocol = "tcp"
    e_to_port = 80
  },
  "2" = {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "HTTPS OUT"
    e_from_port = 443
    protocol = "tcp"
    e_to_port = 443
  },
  "3" = {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "SSH OUT"
    e_from_port = 22
    protocol = "tcp"
    e_to_port = 22
  },
  "4" = {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "ICMP OUT"
    e_from_port = 0
    protocol = "icmp"
    e_to_port = 0
  }
}

# SG REGLE PRIVATE
sg_ingress_private = {
  "1" = {
    cidr_blocks = [ "10.5.6.0/24", "10.5.7.0/24" ]
    description = "HTTP IN"
    in_from_port = 80
    in_to_port = 80
    protocol = "tcp"
  },
  "2" = {
    cidr_blocks = [ "10.5.6.0/24", "10.5.7.0/24" ]
    description = "HTTPS IN"
    in_from_port = 443
    in_to_port = 443
    protocol = "tcp"
  },
  "3" = {
    cidr_blocks = [ "10.5.6.0/24", "10.5.7.0/24" ]
    description = "SSH IN"
    in_from_port = 22
    in_to_port = 22
    protocol = "tcp"
  },
  "4" = {
    cidr_blocks = [ "10.5.6.0/24", "10.5.7.0/24" ]
    description = "ICMP IN"
    in_from_port = 0
    in_to_port = 0
    protocol = "icmp"
  }
}

sg_egress_private = {
  "1" = {
    cidr_blocks = [ "10.5.6.0/24", "10.5.7.0/24" ]
    description = "HTTP OUT"
    e_from_port = 80
    protocol = "tcp"
    e_to_port = 80
  },
  "2" = {
    cidr_blocks = [ "10.5.6.0/24", "10.5.7.0/24" ]
    description = "HTTPS OUT"
    e_from_port = 443
    protocol = "tcp"
    e_to_port = 443
  },
  "3" = {
    cidr_blocks = [ "10.5.6.0/24", "10.5.7.0/24" ]
    description = "SSH OUT"
    e_from_port = 22
    protocol = "tcp"
    e_to_port = 22
  },
  "4" = {
    cidr_blocks = [ "10.5.6.0/24", "10.5.7.0/24" ]
    description = "ICMP OUT"
    e_from_port = 0
    e_to_port = 0
    protocol = "icmp"
  }
}

ami = "ami-03ed65f3373b2718b"
instance_type = "t3.large"
iam_profile = "ugd-smm"
project_name = "sgp"

// Route Table association subnet
route_table = "rtb-0e60a117ec68b7ccd"

// RDS configurations
engine          = "postgres"
engine_version  = "12.7"
family          = "postgres12"
major_engine_version    = "12"
instance_class  = "db.t3.medium"
db_port         = 5432
db              = "sgbdb"
dbuser          = "sgpdbuser"