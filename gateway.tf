resource "aws_internet_gateway" "wal_int_gw" {
  vpc_id = aws_vpc.wal_vpc.id

  tags = {
    Name = "Wal Internet Gateway"
  }
}