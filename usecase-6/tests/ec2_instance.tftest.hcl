test "basic_ec2_instance" {
  module = "../"  # path to the module being tested

  variables = {
    instance_type = "t2.medium"
    ami_id        = "ami-020cba7c55df1f615"
  }

  assert {
    condition = module.instance_type == "t2.medium"
    message   = "Instance type should be t2.medium"
  }

  assert {
    condition = module.ami_id != ""
    message   = "AMI ID should not be empty"
  }
}
