output "efs_mount_dns_subnet_01" {
  value = aws_efs_mount_target.efs_docs_mount_target_subnet_01.mount_target_dns_name
}

output "efs_mount_dns_subnet_02" {
  value = aws_efs_mount_target.efs_docs_mount_target_subnet_02.mount_target_dns_name
}
