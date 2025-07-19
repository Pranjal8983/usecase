resource "aws_ecr_repository" "ecr" {
  for_each = toset(var.repo_name)
 
  name = each.key
}
 
resource "aws_ecr_lifecycle_policy" "ecr" {
  for_each = aws_ecr_repository.ecr
 
repository = each.value.name
 
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain only last 5 images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
