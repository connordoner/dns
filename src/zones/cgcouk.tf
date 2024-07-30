# DNS zone itself
resource "aws_route53_zone" "cgcouk" {
  name = "connorgurney.co.uk"
  tags = {
    "connorgurney:workload" = "cgcouk"
  }
}

# Root TXT records
# I do this here as Amazon Route 53 doesn’t support having more than one TXT record at the root of the zone.
resource "aws_route53_record" "cgcouk_root_txt" {
  zone_id = aws_route53_zone.cgcouk.zone_id
  name    = ""
  type    = "TXT"
  ttl     = "3600"
  records = [
    # Email SPF
    # This is set as it is as I don’t send email from this domain.
    "v=spf1 -all",

    # Apple domain verification
    "apple-domain=bx7QcUxkocqL0mX0"
  ]
}

# Email routing
resource "aws_route53_record" "cgcouk_mx" {
  zone_id = aws_route53_zone.cgcouk.zone_id
  name    = ""
  type    = "MX"
  ttl     = "3600"
  records = [
    "10 mx01.mail.icloud.com",
    "10 mx02.mail.icloud.com"
  ]
}

# Email DMARC
# This is set as it is as I don’t send email from this domain.
resource "aws_route53_record" "cgcouk_dmarc" {
  zone_id = aws_route53_zone.cgcouk.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; adkim=s; aspf=s; fo=1; rua=mailto:postmaster@connorgurney.co.uk; ruf=mailto:postmaster@connorgurney.co.uk"
  ]
}

# Email DKIM
resource "aws_route53_record" "cgcouk_dkim" {
  zone_id = aws_route53_zone.cgcouk.zone_id
  name    = "*._domainkey"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p="
  ]
}
