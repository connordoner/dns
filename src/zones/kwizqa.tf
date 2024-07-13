# DNS zone itself
resource "aws_route53_zone" "kwizqa" {
  name = "kwiz.qa"
  tags = {
    "connorgurney:workload" = "kwizqa"
  }
}
