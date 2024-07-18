resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each = var.role_policy_details

  role = each.key
  policy_arn = each.value
}