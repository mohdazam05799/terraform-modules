variable "role_policy_details" {
  type = map(list(string))
  default = {
    "role1" = ["value", "value2"]
    "role2" = ["value","value3"]
  }
}