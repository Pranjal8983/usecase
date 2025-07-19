output "alb_dns_name" {
  value = aws_lb.this.dns_name
}


output "appointments_tg_arn" {
  value = aws_lb_target_group.appointments.arn
}

output "patients_tg_arn" {
  value = aws_lb_target_group.patients.arn
}
