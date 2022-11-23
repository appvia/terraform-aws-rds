
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "tag:Database"
    values = ["true"]
  }

  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_security_groups" "selected" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }

  filter {
    name   = "tag:Name"
    values = [format("terranetes-%s-db-sg", var.environment)]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.4.0"

  identifier        = var.name
  engine            = "mysql"
  engine_version    = "5.7.40"
  instance_class    = var.instance
  allocated_storage = var.storage

  db_name                 = var.name
  username                = var.database_username
  password                = var.database_password
  port                    = "3306"
  backup_window           = "03:00-06:00"
  backup_retention_period = var.backup_retention_period
  maintenance_window      = "Mon:00:00-Mon:03:00"
  skip_final_snapshot     = true
  vpc_security_group_ids  = data.aws_security_groups.selected.ids

  tags = {
    Environment = var.environment
  }

  create_db_subnet_group = false
  db_subnet_group_name   = format("terranetes-%s-db", var.environment)
  deletion_protection    = false
  family                 = "mysql5.7"
  major_engine_version   = "5.7"
  subnet_ids             = data.aws_subnets.selected.ids

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"
      option_settings = [
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
      ]
    },
  ]
}
