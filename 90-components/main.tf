module "main" {
    source = "git::https://github.com/Jaswanth374/terraform-roboshop-component.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
}