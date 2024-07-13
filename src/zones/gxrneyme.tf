# DNS zone itself
resource "aws_route53_zone" "gxrneyme" {
  name = "gxrney.me"
  tags = {
    "connorgurney:workload" = "gxrneyme"
  }
}

# Apple domain verification
resource "aws_route53_record" "gxrneyme_apple_verification" {
  zone_id = aws_route53_zone.gxrneyme.zone_id
  name    = "@"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "apple-domain=2SFecY4bMX7IXcpI"
  ]
}

# Email routing
resource "aws_route53_record" "gxrneyme_mx" {
  zone_id = aws_route53_zone.gxrneyme.zone_id
  name    = "@"
  type    = "MX"
  ttl     = "3600"
  records = [
    "10 mx01.mail.icloud.com",
    "10 mx02.mail.icloud.com"
  ]
}

# Email SPF
# This is set as it is as I don’t send email from this domain.
resource "aws_route53_record" "gxrneyme_spf" {
  zone_id = aws_route53_zone.gxrneyme.zone_id
  name    = "@"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 -all"
  ]
}

# Email DMARC
# This is set as it is as I don’t send email from this domain.
resource "aws_route53_record" "gxrneyme_dmarc" {
  zone_id = aws_route53_zone.gxrneyme.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; adkim=s; aspf=s; fo=1; rua=mailto:postmaster@gxrney.me; ruf=mailto:postmaster@gxrney.me"
  ]
}

# Email DKIM
resource "aws_route53_record" "gxrneyme_dkim" {
  zone_id = aws_route53_zone.gxrneyme.zone_id
  name    = "*._domainkey"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p="
  ]
}