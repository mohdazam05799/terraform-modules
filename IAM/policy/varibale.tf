variable "policies" {
  type = list(object({
    name     = string
    document = any
  }))
  default = []
}


