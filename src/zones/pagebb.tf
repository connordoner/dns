# DNS zone itself
resource "aws_route53_zone" "pagebb" {
  name = "pagebb.net"
  tags = {
    "connorgurney:workload" = "pagebb"
  }
}

# Root TXT records
# I do this here as Amazon Route 53 doesn’t support having more than one TXT record at the root of the zone.
resource "aws_route53_record" "pagebb_root_txt" {
  zone_id = aws_route53_zone.pagebb.zone_id
  name    = ""
  type    = "TXT"
  ttl     = "3600"
  records = [
    # Inbound email SPF
    # This is set as it is as I don’t send email from this domain.
    "v=spf1 -all",

    # Apple domain verification
    "apple-domain=18kCqeCndYjeoxOZ",

    # Google Site Verification
    "google-site-verification=fZ-3Ox9WJkUl9tD4t1h9AeLuUfhcnD7rsdxSKkfal4g"
  ]
}

# Email routing
resource "aws_route53_record" "pagebb_inbound_mx" {
  zone_id = aws_route53_zone.pagebb.zone_id
  name    = ""
  type    = "MX"
  ttl     = "3600"
  records = [
    "10 mx01.mail.icloud.com",
    "10 mx02.mail.icloud.com"
  ]
}

resource "aws_route53_record" "pagebb_outbound_mx" {
  zone_id = aws_route53_zone.pagebb.zone_id
  name    = "outbound"
  type    = "MX"
  ttl     = "3600"
  records = [
    "10 feedback-smtp.eu-west-2.amazonses.com"
  ]
}

# Outbound enail SPF
resource "aws_route53_record" "pagebb_outbound_spf" {
  zone_id = aws_route53_zone.pagebb.zone_id
  name    = "outbound"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=spf1 include:amazonses.com -all"
  ]
}

# Email DMARC
# This is set as it is as I only send email.
resource "aws_route53_record" "pagebb_dmarc" {
  zone_id = aws_route53_zone.pagebb.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; adkim=s; aspf=s; fo=1; rua=mailto:postmaster@pagebb.net; ruf=mailto:postmaster@pagebb.net"
  ]
}

# Email DKIM
resource "aws_route53_record" "pagebb_dkim_1" {
  zone_id = aws_route53_zone.pagebb.zone_id
  name    = "jipoybwnp67evqmblxput5acfnrb6w3i._domainkey"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "jipoybwnp67evqmblxput5acfnrb6w3i.dkim.amazonses.com"
  ]
}

resource "aws_route53_record" "pagebb_dkim_2" {
  zone_id = aws_route53_zone.pagebb.zone_id
  name    = "cdyrulfd7fvknppkthe3l2zwejsjyeg4._domainkey"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "cdyrulfd7fvknppkthe3l2zwejsjyeg4.dkim.amazonses.com"
  ]
}

resource "aws_route53_record" "pagebb_dkim_3" {
  zone_id = aws_route53_zone.pagebb.zone_id
  name    = "bxwzkebpb7s45rcbinnwjyw5mjo6enul._domainkey"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "bxwzkebpb7s45rcbinnwjyw5mjo6enul.dkim.amazonses.com"
  ]
}
