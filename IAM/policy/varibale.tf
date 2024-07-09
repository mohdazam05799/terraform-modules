variable "policies" {
  type = list(object({
    name     = string
    document = any
  }))
  default = []
}

output "policy_arns" {
  value = [for p in aws_iam_policy.policies : p.arn]
}
