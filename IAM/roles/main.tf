
resource "aws_iam_role" "roles" {
  count               = length(var.roles)
  name                = var.roles[count.index].name
  assume_role_policy  = jsonencode(var.roles[count.index].assume_role_policy)
}

output "role_arns" {
  value = [for r in aws_iam_role.roles : r.arn]
}