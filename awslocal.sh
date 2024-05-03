#!/bin/sh

# Create a new S3 bucket
awslocal s3api create-bucket --bucket pern-frontend-bucket

# Check if the bucket was created
awslocal s3api list-buckets

# List the contents of the bucket
awslocal s3 ls s3://pern-store-bucket

# Upload the front end files to the bucket
awslocal s3 cp . s3://pern-store-bucket --recursive

# Implement cloudformation to create a new stack
awslocal cloudformation create-stack --stack-name pern-frontend-stack --template-body file://frontend.yaml

# Describe the stack
awslocal cloudformation describe-stacks --stack-name pern-frontend-stack

# Delete the stack
awslocal cloudformation delete-stack --stack-name pern-backend-stack

# List resources in the stack
awslocal cloudformation list-stack-resources --stack-name pern-backend-stack

# Check status of the stack
awslocal cloudformation describe-stacks --stack-name pern-backend-stack

# List all the stacks 
awslocal cloudformation list-stacks

# Get output of the stack
awslocal cloudformation describe-stacks --stack-name pern-frontend-stack

# List listeners
awslocal elbv2 describe-listeners --load-balancer-arn

# List target groups
awslocal elbv2 describe-target-groups --load-balancer-arn

# List load balancers       
awslocal elbv2 describe-load-balancers

# List ECS services
awslocal ecs list-services

# Details of the ECS service
awslocal ecs describe-services --cluster ECSCluster-df1cb283 --service s-bea86f17

# List ECS clusters
awslocal ecs list-clusters

# Details of task definition
awslocal cloudformation create-stack --stack-name pern-network-stack --template-body file://network.yaml

awslocal cloudformation describe-stacks --stack-name pern-network-stack

awslocal cloudformation create-stack --stack-name pern-frontend-stack --template-body file://frontend.yaml

awslocal cloudformation describe-stacks --stack-name pern-frontend-stack

awslocal cloudformation create-stack --stack-name pern-backend-stack --template-body file://backend.yaml

awslocal cloudformation describe-stacks --stack-name pern-backend-stack

awslocal cloudformation delete-stack --stack-name pern-network-stack
awslocal cloudformation delete-stack --stack-name pern-frontend-stack
awslocal cloudformation delete-stack --stack-name pern-backend-stack

awslocal cloudformation update-stack --stack-name pern-network-stack --template-body file://network.yaml

# pern-frontend-stack
# pern-network-stack
# pern-backend-stack