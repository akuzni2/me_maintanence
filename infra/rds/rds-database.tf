module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "me-maintenance"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "me-maintenance" {
  name       = "me-maintenance"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "me-maintenance"
  }
}

resource "aws_security_group" "rds" {
  name   = "me_maintenance_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "me_maintenance_rds"
  }
}

resource "aws_db_parameter_group" "me-maintenance" {
  name   = "me-maintenance"
  family = "postgres12"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "me-maintenance" {
  identifier             = "me-maintenance"
  instance_class         = "db.t2.micro"
  allocated_storage      = 5
  max_allocated_storage  = 10
  engine                 = "postgres"
  engine_version         = "12.8"
  username               = "main_user"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.me-maintenance.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.me-maintenance.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

data "aws_availability_zones" "available" {}