provider "aws" {
    region = "us-east-1"
}

resource "aws_eks_cluster" "my_cluster" {
    name = "my-eks-cluster"
    role_arn = aws_iam_role.eks-role-terraform.arn
    vpc_config {
      subnet_ids = ["subnet-0670bc5b424180d00", "subnet-0380664ab66dcbe35"]
    }
}

resource "aws_iam_role" "eks-role-terraform" {
    name = "eks-role-terraform"
    assume_role_policy = data.aws_iam_policy_document.eks-role-policy.json
}

data "aws_iam_policy_document" "eks-role-policy" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["eks.amazonaws.com"]
        }
    }
}
