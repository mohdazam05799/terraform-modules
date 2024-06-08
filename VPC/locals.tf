locals {
  project = var.project
  env     = var.env
  Team    = "DevOps"
  common_tags = {
    project = var.project
    env     = var.env
  }
}