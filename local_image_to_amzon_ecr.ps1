# List Docker images (for user reference)
docker image ls

# Prompt for user inputs
$imageName = Read-Host "Enter your Docker image name you want to push to Amazon ECR"
$accountId = Read-Host "Enter your AWS Account ID"
$repositoryName = Read-Host "Enter your ECR repository name"
$region = Read-Host "Enter the AWS region"
$imageTag = Read-Host "Enter the Docker image tag (e.g., latest, 1.0.0)"

# Login to ECR (public or private based on repository type)
# Use ecr for private repositories and ecr-public for public repositories
$loginCommand = "aws ecr get-login-password --region $region | docker login --username AWS --password-stdin ${accountId}.dkr.ecr.${region}.amazonaws.com"
Invoke-Expression $loginCommand

# Tag the Docker image
docker tag "${imageName}:${imageTag}" "${accountId}.dkr.ecr.${region}.amazonaws.com/${repositoryName}:${imageTag}"

# Push the Docker image to ECR
docker push "${accountId}.dkr.ecr.${region}.amazonaws.com/${repositoryName}:${imageTag}"

Write-Host "Docker image pushed to ECR successfully."
