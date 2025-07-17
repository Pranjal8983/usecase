package main

# Deny overly frequent event schedules
deny[msg] {
  input.resource_type == "aws_scheduler_schedule"
  re_match("cron\\(\\*/(3|5)\\s.*\\)", input.config.schedule_expression)
  msg = sprintf("Event '%s' has a schedule that is too frequent: %s", [input.name, input.config.schedule_expression])
}
