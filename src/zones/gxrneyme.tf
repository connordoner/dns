# DNS zone itself
resource "aws_route53_zone" "gxrneyme" {
  name = "gxrney.me"
  tags = {
    "connorgurney:workload" = "gxrneyme"
  }
}
