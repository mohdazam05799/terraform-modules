resource "aws_iam_policy" "policies" {
  count      = length(var.policies)
  name       = var.policies[count.index].name
  policy     = var.policies[count.index].document
}