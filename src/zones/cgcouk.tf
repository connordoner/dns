# DNS zone itself
resource "aws_route53_zone" "cgcouk" {
  name = "connorgurney.co.uk"
  tags = {
    "connorgurney:workload" = "cgcouk"
  }
}
