resource "aws_ecr_repository" "patient" {
  name = "patient-service"
}

resource "aws_ecr_repository" "appointment" {
  name = "appointment-service"
}
