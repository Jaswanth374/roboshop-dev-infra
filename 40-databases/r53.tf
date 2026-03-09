resource "aws_route53_record" "mongodb" {
  # Reference the zone_id from the 'example_zone' resource
  zone_id = var.zone_id
  name    = "mongodb-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1 # Time-to-Live in seconds
  records = aws_instance.mongodb.private_ip
}

resource "aws_route53_record" "redis" {
  # Reference the zone_id from the 'example_zone' resource
  zone_id = var.zone_id
  name    = "redis-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1 # Time-to-Live in seconds
  records = aws_instance.redis.private_ip
}

resource "aws_route53_record" "mysql" {
  # Reference the zone_id from the 'example_zone' resource
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1 # Time-to-Live in seconds
  records = aws_instance.mysql.private_ip
}

resource "aws_route53_record" "rabbitmq" {
  # Reference the zone_id from the 'example_zone' resource
  zone_id = var.zone_id
  name    = "rabbitmq-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1 # Time-to-Live in seconds
  records = aws_instance.rabbitmq.private_ip
}