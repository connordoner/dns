# DNS zone itself
resource "aws_route53_zone" "cgmeuk" {
  name = "connorgurney.me.uk"
  tags = {
    "connorgurney:workload" = "cgmeuk"
  }
}
