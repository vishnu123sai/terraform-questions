The ci user needs permission to push Docker images to one ECR repository, deploy to one ECS service, and read files from one S3 bucket.

I did not allow deleting images or services, or uploading and deleting S3 files, because the CI pipeline does not need these permissions.

I also limited access to the ECS roles needed for deployment.

This keeps the ci user limited to the tasks it needs to perform and helps protect other AWS resources