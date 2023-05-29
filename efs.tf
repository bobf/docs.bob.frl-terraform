resource "aws_efs_file_system" "efs_docs" {
  creation_token = "docs"

  tags = {
    Name = "efs_docs"
  }
}

resource "aws_efs_mount_target" "efs_docs_mount_target_subnet_01" {
  file_system_id = aws_efs_file_system.efs_docs.id
  subnet_id = aws_subnet.internal_subnet_01.id
  ip_address = "10.0.1.144"
  security_groups = [aws_security_group.sg_efs.id]
}

resource "aws_efs_mount_target" "efs_docs_mount_target_subnet_02" {
  file_system_id = aws_efs_file_system.efs_docs.id
  subnet_id = aws_subnet.internal_subnet_02.id
  ip_address = "10.0.2.144"
  security_groups = [aws_security_group.sg_efs.id]
}
