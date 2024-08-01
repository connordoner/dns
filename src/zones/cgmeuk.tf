# DNS zone itself
resource "aws_route53_zone" "cgmeuk" {
  name = "connorgurney.me.uk"
  tags = {
    "connorgurney:workload" = "cgmeuk"
  }
}

# Root TXT records
# I do this here as Amazon Route 53 doesn’t support having more than one TXT record at the root of the zone.
resource "aws_route53_record" "cgmeuk_root_txt" {
  zone_id = aws_route53_zone.cgmeuk.zone_id
  name    = ""
  type    = "TXT"
  ttl     = "3600"
  records = [
    # Email SPF
    "v=spf1 include:icloud.com -all",

    # Apple domain verification
    "apple-domain=bspmYxr24yNNDCpD"
  ]
}

# Root record
resource "aws_route53_record" "cgmeuk_root" {
  zone_id = aws_route53_zone.cgmeuk.zone_id
  name    = ""
  type    = "ALIAS"
  ttl     = "3600"
  records = [
    "www.connorgurney.me.uk."
  ]
}

# WWW record
resource "aws_route53_record" "cgmeuk_www" {
  zone_id = aws_route53_zone.cgmeuk.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "d36bj2gmhc6qn1.cloudfront.net"
  ]
}

# Email routing
resource "aws_route53_record" "cgmeuk_mx" {
  zone_id = aws_route53_zone.cgmeuk.zone_id
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
resource "aws_route53_record" "cgmeuk_dmarc" {
  zone_id = aws_route53_zone.cgmeuk.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "v=DMARC1; p=reject; adkim=s; aspf=s; fo=1; rua=mailto:postmaster@connorgurney.me.uk; ruf=mailto:postmaster@connorgurney.me.uk"
  ]
}

# Email DKIM
resource "aws_route53_record" "cgmeuk_dkim" {
  zone_id = aws_route53_zone.cgmeuk.zone_id
  name    = "sig1._domainkey"
  type    = "CNAME"
  ttl     = "3600"
  records = [
    "sig1.dkim.connorgurney.me.uk.at.icloudmailadmin.com"
  ]
}
