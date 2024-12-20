provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = "arn:aws:iam::047719656762:role/eks-role"

  vpc_config {
    subnet_ids = [
      "subnet-0670bc5b424180d00",
      "subnet-0380664ab66dcbe35"
    ]
  }
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name  = aws_eks_cluster.my_cluster.name
  node_role_arn = "arn:aws:iam::047719656762:role/eks-role"
  subnet_ids    = [
    "subnet-0670bc5b424180d00",
    "subnet-0380664ab66dcbe35"
  ]

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [aws_eks_cluster.my_cluster]

  tags = {
    Name = "my-eks-node-group"
  }
}
