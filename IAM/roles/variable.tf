variable "roles" {
  type = list(object({
    name               = string
    assume_role_policy = any
  }))
  default = []
}

