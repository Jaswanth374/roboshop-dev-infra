module "main" {
    source = "git::https://github.com/Jaswanth374/terraform-roboshop-component.git?ref=main"
    for_each = var.component
    component = each.key
    rule_priority = each.value.rule_priority
}