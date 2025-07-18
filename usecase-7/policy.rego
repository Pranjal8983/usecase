package github

deny[msg] {
  input.action == "delete"
  msg = "Deleting resources is not allowed"
}
