resource "cloudflare_record" "dns" {
  zone_id = var.zone_id
  name    = var.name
  value   = var.value
  type    = var.type
  ttl     = var.proxied ? 1 : var.ttl
  proxied = var.proxied
}

resource "aws_route53_record" "dns" {
  zone_id = lookup(var.zone_map, var.zone_id)
  name    = var.name
  type    = var.type
  ttl     = var.ttl
  records = [var.value]
}
