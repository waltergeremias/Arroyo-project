variable "access_key" {}
variable "secret_key" {}
variable "user_name" {}
variable "private_key_path" {}
variable "dkr_login" {}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

variable "awsprops" {
    type = map
    default = {
    region = "us-east-1"
    ami = "ami-051f7e7f6c2f40dc1"
    itype = "t2.micro"
    subnet = "wal_private_subnet"
    publicip = true
    secgroupname = "WAL-Sec-Group"
  }
}

resource "random_password" "root"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "secretDB" {
  name = "MAccountdb"

  tags = {
    name = "MAccountdb"
  }

}
resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.secretDB.id
  secret_string = <<EOF
   {
    "username": "root",
    "password": "${random_password.root.result}"
   }
EOF
}

data "aws_secretsmanager_secret" "secretDB" {
  arn = aws_secretsmanager_secret.secretDB.arn
}
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.secretDB.arn
}
locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}
output "ec2instance" {
  value = aws_instance.project-wal.public_ip
}
