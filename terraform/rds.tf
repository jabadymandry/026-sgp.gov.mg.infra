################################################################################
# RDS Module
################################################################################

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~>3.3.0"
  identifier = "bdd-${var.instance_name}"
  multi_az = true
  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  family               = "${var.family}" # DB parameter group
  major_engine_version = "${var.major_engine_version}"        # DB option group
  instance_class       = "${var.instance_class}"

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_encrypted     = false

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  name     = "${var.db}"
  username = "${var.dbuser}"
  password = "${var.dbpass}"
  port     = "${var.db_port}"

  //multi_az               = true
  subnet_ids              = [ for subnet in aws_subnet.private_subnet : subnet.id ]
  vpc_security_group_ids  = [ aws_security_group.sg_private.id ]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = false
  performance_insights_retention_period = 7
  create_monitoring_role                = false
  monitoring_interval                   = 0

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  tags = {
    Name            = "bdd-${var.project_name}"
    environnement   = "${var.environnement}"
    projet          = "${var.project_name}"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
}
