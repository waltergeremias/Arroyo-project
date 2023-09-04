

resource "aws_db_instance" "waldb" {
  depends_on             = [aws_security_group.rds_sg]
  engine                 = "mysql"
  identifier             = "database1"
  db_name                = "mysqldb"
  allocated_storage      = "20"
  engine_version         = "8.0"
  storage_type           = "gp2"
  instance_class         = "db.t2.micro"
  username               = local.db_creds.username
  password               = local.db_creds.password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  skip_final_snapshot    = "true"
}