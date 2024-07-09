resource "aws_key_pair" "key" {
  key_name   = var.key_pair_name ? var.key_pair_name : "EKS-Key"
  public_key = file(var.public_key_path)

}