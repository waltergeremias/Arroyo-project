resource "aws_instance" "project-wal" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name         = "ssh-key"
  security_groups = ["${aws_security_group.project-wal-sg.id}"]

  root_block_device {
    delete_on_termination = true
    volume_size = 50
    volume_type = "standard"
  }
  tags = {
    Name ="LinuxServ"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "WAL"
  }
  subnet_id = aws_subnet.wal_private_subnet.id
  depends_on = [ aws_security_group.project-wal-sg ]
}
resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7rF2dTw2Br09ebbj/fPbvbwIf6e0PEDPxNrGxjoCxfcbfmaCRKAK9H1l8dyy75s9dgVxudvqOk0/H6An2ZfcKEnhx01wk0I/Zm1fd9x5pJlBAriQff3viRXsnMcihY+6xhubeeyVLOUVZPnOAN9o/dlR/ZqVv3MMOE2hkQ91LTvPlzGMO/mjHD0mZXbfumD0RxWN8mLDkdjDVt98DnmIMWomISj26TFX1ha+zrjFTWdYxBhmstpeBxruXHOX6MAbyrqxPSfHPkCF2Ze43lmoWhjsTiE+cYvY/rHaM3vZRHlomAIfnnnHn14wjdEV+1Q61GUuM8m045Vs6IdvzkYil kapsch@WGM-S-W-IOS-1"
}