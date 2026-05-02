# ECR

module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "vote"

  repository_read_write_access_arns = ["arn:aws:iam::036449353321:user/github"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 3 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 3
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
