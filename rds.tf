#----------------------------- -----------------------------
#----------------------------- -----------------------------

resource "aws_db_parameter_group" "mysql_standalone_parameter_group" {
  name   = "${var.project}-${var.environment}-mysql-standalone-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

}

#----------------------------- -----------------------------
# RDS option group
#----------------------------- -----------------------------

resource "aws_db_option_group" "aws_standalone_option_group" {
  name                 = "${var.project}-${var.environment}-mysql-standalone-og"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

#----------------------------- -----------------------------
# RDS subnet group
#----------------------------- -----------------------------
resource "aws_db_subnet_group" "mysql_standalone_subnetgroup" {
  name = "${var.project}-${var.environment}-mysql-standalone-sg"
  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1c.id
  ]

  tags = {
    Name    = "${var.project}-${var.environment}-mysql-standalone-sg"
    Project = var.project
    Env     = var.environment
  }

}
#----------------------------- -----------------------------
# RDS random password
#----------------------------- -----------------------------
resource "random_string" "db_password" {
  length  = 16
  special = false
}

#----------------------------- -----------------------------
# RDS INstance
#----------------------------- -----------------------------
resource "aws_db_instance" "mysql_standalone" {

  engine         = "mysql"
  engine_version = "8.0"
  identifier     = "${var.project}-${var.environment}-mysql-standalone"

  username = "admin"
  password = random_string.db_password.result

  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50

  storage_type      = "gp2"
  storage_encrypted = false

  multi_az          = false
  availability_zone = "ap-northeast-1a"

  db_subnet_group_name   = aws_db_subnet_group.mysql_standalone_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  publicly_accessible = false
  port                = 3306
  name                = "tastylogdb"

  parameter_group_name = aws_db_parameter_group.mysql_standalone_parameter_group.name
  option_group_name    = aws_db_option_group.aws_standalone_option_group.name

  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = false

  deletion_protection = true
  skip_final_snapshot = false
  apply_immediately   = true
  tags = {
    Name    = "${var.project}-${var.environment}-mysql-standalone"
    Project = var.project
    Env     = var.environment
  }
}


