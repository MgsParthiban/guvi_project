#!/bin/bash

source ./secret.txt
source ./.env

# Pull the Docker image and store the output
Image_name=$pub_repo

echo $Image_name

# Extract the tag from the image name line
#image=$(echo "$Image_name" | grep -oE "[^ ]+:[^ ]+" | tail -n 1 | awk '{print }')
#echo $image
docker_hub_ID=$(echo "$Image_name" | awk -F '/' '{print $1}')
prod_repo=$(echo "$docker_hub_ID/prod")
tag=$(echo "$Image_name" | awk -F ':' '{print $2}')
prod_image=$(echo "$prod_repo:$tag")

echo "The Docker hub user Id is : $docker_hub_ID"
echo "The Docker hub user prod re-name is : $prod_repo"
echo "The tag number is: $tag"
echo "the private registry image : $prod_image"

echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin


docker tag $Image_name $prod_image

sed -i '/^private_repo=/d' .env
echo "private_repo=$prod_image" >> .env


dockerCompose_path=$(find . -type f -name "docker-compose.yml")

# Get the directory containing the Dockerfile
dockerCompose_dir=$(dirname "$dockerCompose_path")

# Navigate to the directory
cd "$dockerCompose_dir" || exit

# Print the path of the Dockerfile
echo "Docker compose file  found in: $(pwd)"

# Start the Docker Compose services
docker-compose --env-file .env up -d


docker push $prod_image

