provider "aws" {
  alias  = "account_a"
  region = "ap-south-1"
}

resource "aws_iam_user" "engine" {
  provider = aws.account_a
  name     = "engine"
}

resource "aws_iam_user" "ci" {
  provider = aws.account_a
  name     = "ci"
}

resource "aws_iam_user" "alice" {
  provider = aws.account_a
  name     = "alice"
}

resource "aws_iam_user" "bob" {
  provider = aws.account_a
  name     = "bob"
}

resource "aws_iam_group" "group1" {
  provider = aws.account_a
  name     = "group1"
}

resource "aws_iam_group" "group2" {
  provider = aws.account_a
  name     = "group2"
}

resource "aws_iam_group_membership" "group1_members" {
  provider = aws.account_a
  name     = "group1-members"

  users = [
    aws_iam_user.engine.name,
    aws_iam_user.ci.name
  ]

  group = aws_iam_group.group1.name
}

resource "aws_iam_group_membership" "group2_members" {
  provider = aws.account_a
  name     = "group2-members"

  users = [
    aws_iam_user.alice.name,
    aws_iam_user.bob.name
  ]

  group = aws_iam_group.group2.name
}

resource "aws_iam_group_policy" "group1_deny_console" {
  provider = aws.account_a
  name     = "deny-console-login"
  group    = aws_iam_group.group1.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Deny"
      Action   = "aws-portal:*"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role" "roleA" {
  provider = aws.account_a
  name     = "roleA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { AWS = "arn:aws:iam::000000000000:root" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "roleA_admin" {
  provider   = aws.account_a
  role       = aws_iam_role.roleA.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy" "roleA_no_iam" {
  provider = aws.account_a
  name     = "deny-iam"
  role     = aws_iam_role.roleA.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Deny"
      Action   = "iam:*"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role" "roleB" {
  provider = aws.account_a
  name     = "roleB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { AWS = "arn:aws:iam::000000000000:root" }
    }]
  })
}

resource "aws_iam_role_policy" "roleB_assume_roleC" {
  provider = aws.account_a
  name     = "assume-roleC"
  role     = aws_iam_role.roleB.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sts:AssumeRole"
      Resource = "arn:aws:iam::111111111111:role/roleC"
    }]
  })
}