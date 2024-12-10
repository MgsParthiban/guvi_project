#!/bin/bash

echo "Current directory: $(pwd)" 
# Source the .env file and check if it loads correctly
source ./.env
source ./secret.txt

image_name=$IMAGE_NAME

echo "$image_name"

build_number=${BUILD_NUMBER:-"latest"}

dev_image="$image_name:$build_number"

echo "$dev_image"

dockerfile_path=$(find . -type f -name "Dockerfile")

# Get the directory containing the Dockerfile
dockerfile_dir=$(dirname "$dockerfile_path")

echo "$dockerfile_dir"

# Navigate to the directory
cd "$dockerfile_dir" || exit

# Print the path of the Dockerfile
echo "Dockerfile found in: $(pwd)"

# Execute the docker build command
docker build -t $dev_image .

echo "Docker image built with tag: $image_tag"

sed -i '/^pub_repo=/d' .env
echo "pub_repo=$dev_image" >> .env

echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin

docker push $dev_image

