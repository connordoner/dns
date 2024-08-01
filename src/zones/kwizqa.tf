# DNS zone itself
resource "aws_route53_zone" "kwizqa" {
  name = "kwiz.qa"
  tags = {
    "connorgurney:workload" = "kwizqa"
  }
}

# Root TXT records
# I do this here as Amazon Route 53 doesn’t support having more than one TXT record at the root of the zone.
resource "aws_route53_record" "kwizqa_root_txt" {
  zone_id = aws_route53_zone.kwizqa.zone_id
  name    = ""
  type    = "TXT"
  ttl     = "3600"
  records = [
    # Email SPF
    # This is set as it is as I don’t send email from this domain.
    "v=spf1 -all",

    # Google Site Verification
    "google-site-verification=ZDWGnunBKiGd-6Z4evyfZjEt70N5G0bmnb4tpK_CRdY"
  ]
}

# Email routing
resource "aws_route53_record" "kwizqa_mx" {
  zone_id = aws_route53_zone.kwizqa.zone_id
  name    = ""
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 ."
  ]
}

# Email DMARC
# This is set as it is as I don’t send email from this domain.
resource "aws_route53_record" "kwizqa_dmarc" {
  zone_id = aws_route53_zone.kwizqa.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; adkim=s; aspf=s; fo=1"
  ]
}

# Email DKIM
resource "aws_route53_record" "kwizqa_dkim" {
  zone_id = aws_route53_zone.kwizqa.zone_id
  name    = "*._domainkey"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DKIM1; p="
  ]
}
