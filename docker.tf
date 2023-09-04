resource "aws_ecr_repository" "ecr_repo_wal" {
  name                 = "ecr_wal"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

locals {
ecr_reg   = "${var.user_name}.dkr.ecr.us-east-1.amazonaws.com"
ecr_repo  = "ecr_wal"
image_tag = "latest"

dkr_img_src_path = "${path.module}/docker"
dkr_img_src_sha256 = sha256(join("", [for f in fileset(".", "${local.dkr_img_src_path}/**") : file(f)]))

dkr_build_cmd = <<-EOT
        docker build -t ${local.ecr_reg}/${local.ecr_repo}:${local.image_tag} \
            -f ${local.dkr_img_src_path}/Dockerfile .

        aws ecr get-login-password --region us-east-1 | \
            docker login --username ${var.user_name} --password-stdin ${local.ecr_reg}

        docker push ${local.ecr_reg}/${local.ecr_repo}:${local.image_tag}
    EOT

}

variable "force_image_rebuild" {
type    = bool
default = true
}

resource "null_resource" "build_push_dkr_img" {
triggers = {
detect_docker_source_changes = var.force_image_rebuild == true ? timestamp() : local.dkr_img_src_sha256
}

provisioner "local-exec" {
command = local.dkr_build_cmd
}
}

output "trigged_by" {
value = null_resource.build_push_dkr_img.triggers
}
