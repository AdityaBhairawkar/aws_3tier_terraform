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
  identifier             = "tier3-app-db"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = "todo_app"
  username               = "root"
  password               = "password"
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