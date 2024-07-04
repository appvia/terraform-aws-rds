module "rds" {
  #checkov:skip=CKV_TF_1:Expects module sources to use commit hash
  #checkov:skip=CKV_AWS_129:RDS Logs
  #checkov:skip=CKV_AWS_118:Enhanced Monitoring
  #checkov:skip=CKV_AWS_161:IAM Auth
  #checkov:skip=CKV_AWS_293:Deletion Protection
  #checkov:skip=CKV_AWS_353:Enabled Performance Insights
  #checkov:skip=CKV_AWS_354:Encrypted Performance Insights
  #checkov:skip=CKV_AWS_157:Multi-AZ
  source  = "terraform-aws-modules/rds/aws"
  version = "6.7.0"

  allocated_storage       = var.allocated_storage
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  copy_tags_to_snapshot   = true
  create_db_subnet_group  = true
  db_name                 = var.db_name
  db_subnet_group_name    = format("%s-db-group", var.db_name)
  deletion_protection     = false
  engine                  = var.engine
  engine_version          = var.engine_version
  family                  = var.family
  identifier              = var.db_name
  instance_class          = var.instance_class
  kms_key_id              = aws_kms_key.kms.arn
  maintenance_window      = var.maintenance_window
  major_engine_version    = var.major_engine_version
  parameters              = var.parameters
  password                = random_password.password.result
  port                    = var.port
  skip_final_snapshot     = true
  subnet_ids              = var.subnet_ids
  username                = var.username
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_security_group" "rds_sg" {
  #checkov:skip=CKV2_AWS_5:Falsely triggered, associated with RDS
  name        = var.db_name
  description = "Allow inbound traffic to RDS instance: ${var.db_name}"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "rds_allow_ingress" {
  for_each          = var.allowed_cidr_blocks
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = each.value
  description       = "Allow inbound traffic from ${each.key} to RDS instance: ${var.db_name}"
  from_port         = var.port
  ip_protocol       = "tcp"
  to_port           = var.port
}

data "aws_caller_identity" "current" {}

resource "aws_kms_key" "kms" {
  description             = "A symmetric encryption KMS key for RDS: ${var.db_name}"
  enable_key_rotation     = true
  deletion_window_in_days = 7
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow administration of the key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action = [
          "kms:ReplicateKey",
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action = [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext"
        ],
        Resource = "*"
      }
    ]
  })
}
