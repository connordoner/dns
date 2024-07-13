# DNS zone itself
resource "aws_route53_zone" "pagebb" {
  name = "pagebb.net"
  tags = {
    "connorgurney:workload" = "pagebb"
  }
}
