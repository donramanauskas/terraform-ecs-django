resource "aws_codedeploy_app" "codedeploy" {
  name = aws_ecs_cluster.production.name
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name               = aws_codedeploy_app.codedeploy.name
  deployment_config_name = var.deployment_config_name
  deployment_group_name  = aws_ecs_service.production.name
  service_role_arn       = aws_iam_role.codedeploy.arn

  auto_rollback_configuration {
    enabled = var.auto_rollback
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = var.termination_wait
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.production.name
    service_name = aws_ecs_service.production.name
  }


  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_alb_listener.ecs-alb-http-listener-green.arn]
      }

      target_group {
        name = aws_alb_target_group.green.name
      }

      test_traffic_route {
        listener_arns = [aws_alb_listener.ecs-alb-http-listener-blue.arn]
      }

      target_group {
        name = aws_alb_target_group.blue.name
      }
    }
  }
}