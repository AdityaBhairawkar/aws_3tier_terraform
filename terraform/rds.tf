# RDS Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-subnetgroup"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${var.project_name}-subnetgroup"
  }
}

# RDS Database
resource "aws_db_instance" "main" {
  identifier             = "${var.project_name}-db"
  engine                 = "mysql"
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  storage_type           = "gp2"

  db_name                = var.rds_db_name
  username               = var.rds_username
  password               = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  apply_immediately      = true

  tags = {
    Name = "${var.project_name}-db"
  }
}
