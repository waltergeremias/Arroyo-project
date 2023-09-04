resource "aws_subnet" "wal_private_subnet" {
  vpc_id            = aws_vpc.wal_vpc.id
  cidr_block        = "10.0.1.0/24"
  #"${cidrsubnet(aws_vpc.wal_vpc.cidr_block, 3, 1)}"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Wal Public Subnet"
  }
}
resource "aws_subnet" "wal_private_subnet2" {
  vpc_id            = aws_vpc.wal_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Wal Public Subnet2"
  }
}
resource "aws_db_subnet_group" "default" {
  name         = "wal_private_subnet"
  description  = "Database subnet groups for RDS"
  subnet_ids   = [aws_subnet.wal_private_subnet.id, aws_subnet.wal_private_subnet2.id]
}

resource "aws_route_table" "route-table-wal" {
  vpc_id = "${aws_vpc.wal_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.wal_int_gw.id}"
  }
  tags = {
    Name = "wal-route-table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.wal_private_subnet.id}"
  route_table_id = "${aws_route_table.route-table-wal.id}"
}