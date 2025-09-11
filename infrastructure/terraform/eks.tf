resource "aws_eks_cluster" "bedrock" {
  name     = "bedrock-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.29"

  vpc_config {
    subnet_ids = [
      aws_subnet.public_subnet_a.id,
      aws_subnet.public_subnet_b.id
    ]
  }

  tags = { Name = "bedrock-eks-cluster" }
}

resource "aws_eks_node_group" "bedrock_nodes" {
  cluster_name    = aws_eks_cluster.bedrock.name
  node_group_name = "bedrock-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  # Cheapest recommended instance for EKS
  instance_types = ["t3.medium"]

  tags = { Name = "bedrock-node-group" }
}
