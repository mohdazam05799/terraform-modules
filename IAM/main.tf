provider "aws" {
  profile = "acg"
  region  = "us-east-1"

}
locals {
  policy_details = {

  }
}
module "policy" {
  source          = "./policy"
  for_each        = var.policy_details
  policy_name     = each.key
  policy_document = each.value

}

module "role" {
  source             = "./roles"
  assume_role_policy = <<POLICY
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  role_name          = "test-role"
  policy_arn         = module.policy.policy_arn
  depends_on         = [module.policy]

}