locals {
  domain  = "melon.dance"
  zone_id = var.melon_dance_zone_id
}

resource "cloudflare_dns_record" "naus" {
  name    = "naus.${local.domain}"
  content = "192.168.68.53"
  type    = "A"
  ttl     = 300
  zone_id = local.zone_id
}
