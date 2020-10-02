# General
variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "eu-west-1"
}

variable "allowed_accounts" {
  type = list(string)
}

variable "application_name" {
  type = string
  default = "production_app"
}

# networking

variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

# load balancer

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/ping/"
}

# logs

variable "log_retention_in_days" {
  default = 30
}

# key pair

variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}

# ecs

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "production"
}

variable "amis" {
  description = "Which AMI to spawn."
  default = {
    eu-west-1 = "ami-0bf6268a1d7c80226"
  }
}
variable "instance_type" {
  default = "t2.micro"
}
variable "docker_image_url_django" {
  type        = string
  description = "Docker image to run in the ECS cluster"

}
variable "app_count" {
  description = "Number of Docker containers to run"
  default     = 2
}

# auto scaling

variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  default     = "10"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  default     = "4"
}

# rds

variable "rds_db_name" {
  description = "RDS database name"
  default     = "mydb"
}
variable "rds_username" {
  description = "RDS database username"
  default     = "foo"
}
variable "rds_password" {
  description = "RDS database password"
}
variable "rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t2.micro"
}

# CodeDeploy
variable "deployment_config_name" {
  description = "https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html"
  default = "CodeDeployDefault.ECSAllAtOnce"
  type = string
}

variable "auto_rollback" {
  description = "flag roll back failed deployments to previous version"
  default = true
  type = bool
}

variable "termination_wait" {
  description = "wait period before terminating exsisting deployment"
  default = 1
  type = number
}