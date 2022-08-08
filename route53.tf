resource "aws_route53_zone" "route53_zone" {
  name    = "example.com"
  comment = "example.com public zone"
}

resource "aws_route53_record" "route53_record" {
  count   = var.settings.web_app.count
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = "wordpress.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.ec2_instance[count.index].public_ip]
  depends_on = [
    aws_instance.ec2_instance
  ]
}
