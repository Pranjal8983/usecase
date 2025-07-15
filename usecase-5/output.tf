output "sns_arn" {
  value = module.sns_topic.topic_arn
}

output "s3_ibucket" {
  value = module.s3_bucket.i_bucket
}

output "s3_obucket" {
  value = module.s3_bucket.o_bucket
}


