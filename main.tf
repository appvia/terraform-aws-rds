data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.environment]
  }

  filter {
    name   = "tag:appvia.io/managed"
    values = ["true"]
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Network"
    values = ["Private"]
  }

  filter {
    name   = "tag:appvia.io/managed"
    values = ["true"]
  }
}

data "aws_security_groups" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:aws:eks:cluster-name"
    values = [var.environment]
  }
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.0.3"

  allocated_storage       = var.storage
  backup_retention_period = var.backup_retention_period
  backup_window           = var.database_backup_window
  create_db_subnet_group  = true
  db_name                 = var.name
  db_subnet_group_name    = format("%s-db-group", var.name)
  deletion_protection     = false
  engine                  = var.database_engine
  engine_version          = var.database_engine_version
  family                  = var.database_family
  identifier              = var.name
  instance_class          = var.instance
  maintenance_window      = var.database_maintenance_window
  major_engine_version    = var.database_major_engine_version
  options                 = var.database_options
  parameters              = var.database_parameters
  password                = var.database_password
  port                    = var.database_port
  skip_final_snapshot     = true
  subnet_ids              = data.aws_subnets.selected.ids
  username                = var.database_username
  vpc_security_group_ids  = data.aws_security_groups.selected.ids
}
