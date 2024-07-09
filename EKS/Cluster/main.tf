resource "aws_eks_cluster" "eks" {
    name = "${var.project}-${var.env}-cluster"
    role_arn = 
    vpc_config {
      endpoint_private_access = false
      subnet_ids = var.subnet_ids
    }
  
}