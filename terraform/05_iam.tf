resource "aws_iam_role" "ecs-host-role" {
  name               = "ecs_host_role_prod"
  assume_role_policy = file("policies/ecs-role.json")
}

resource "aws_iam_role_policy" "ecs-instance-role-policy" {
  name   = "ecs_instance_role_policy"
  policy = file("policies/ecs-instance-role-policy.json")
  role   = aws_iam_role.ecs-host-role.id
}

resource "aws_iam_role" "ecs-service-role" {
  name               = "ecs_service_role_prod"
  assume_role_policy = file("policies/ecs-role.json")
}

resource "aws_iam_role_policy" "ecs-service-role-policy" {
  name   = "ecs_service_role_policy"
  policy = file("policies/ecs-service-role-policy.json")
  role   = aws_iam_role.ecs-service-role.id
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs_instance_profile_prod"
  path = "/"
  role = aws_iam_role.ecs-host-role.name
}

resource "aws_iam_role" "codedeploy" {
  name               = "production_codedeploy_role"
  assume_role_policy = file("policies/codedeploy-role.json")
}

resource "aws_iam_policy" "codeploy" {
  name   = "production_codedeploy_role_policy"
  policy = file("policies/codedeploy-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "codedeploy" {
  policy_arn = aws_iam_policy.codeploy.arn
  role       = aws_iam_role.codedeploy.name
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy.name
}