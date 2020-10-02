# Production Load Balancer
resource "aws_lb" "production" {
  name               = "${var.ecs_cluster_name}-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.load-balancer.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

# Target group
resource "aws_alb_target_group" "green" {
  name     = "${var.ecs_cluster_name}-tg-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.production-vpc.id

  health_check {
    path                = var.health_check_path
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
}

resource "aws_alb_target_group" "blue" {
  name     = "${var.ecs_cluster_name}-tg-blue"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.production-vpc.id

  health_check {
    path                = var.health_check_path
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
}

# Listener (redirects traffic from the load balancer to the target group)
resource "aws_alb_listener" "ecs-alb-http-listener-green" {
  load_balancer_arn = aws_lb.production.id
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.green]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.green.arn
  }
}

resource "aws_alb_listener" "ecs-alb-http-listener-blue" {
  load_balancer_arn = aws_lb.production.id
  port              = "5000"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.blue]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.blue.arn
  }
}