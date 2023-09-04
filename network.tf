resource "aws_vpc" "wal_vpc" {
  cidr_block      = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Wal VPC"
  }
}

resource "aws_eip" "ip-pub" {
  instance = "${aws_instance.project-wal.id}"
}