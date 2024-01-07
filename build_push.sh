#!/bin/bash

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -n|--image-name) IMAGE_NAME="$2"; shift ;;
    -t|--image-tag) IMAGE_TAG="$2"; shift ;;
    -r|--registry) REGISTRY="$2"; shift ;;
    -u|--username) USERNAME="$2"; shift ;;
    -p|--password) PASSWORD="$2"; shift ;;
    -repo|--repository) REPOSITORY="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# Set default values if not provided
IMAGE_NAME=${IMAGE_NAME:-"parcel-lab"}
IMAGE_TAG=${IMAGE_TAG:-"latest"}
# Set default registry URL
REGISTRY=${REGISTRY:-"https://index.docker.io/v1"}
REPOSITORY=${REPOSITORY:-"petarpe6ev"}

echo "REGISTRY: $REGISTRY"

if [ -z "$IMAGE_NAME" ] || [ -z "$IMAGE_TAG" ] || [ -z "$REGISTRY" ] || [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    echo "Usage: $0 --image-name <name> --image-tag <tag> --registry <registry> --username <username> --password <password> --repository <repository>"
    exit 1
fi

# Build the Docker image
echo "Building the Docker image..."
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Tag the Docker image
echo "Tagging the Docker image..."
docker tag $IMAGE_NAME:$IMAGE_TAG $REPOSITORY/$IMAGE_NAME:$IMAGE_TAG

# Log in to the Docker registry
echo "Logging in to the Docker registry..."
echo "$PASSWORD" | docker login --username $USERNAME --password-stdin $REGISTRY

# Push the Docker image to the registry
echo "Pushing the Docker image to the registry..."

docker push $REPOSITORY/$IMAGE_NAME:$IMAGE_TAG

echo "Docker image has been built and pushed to $REPOSITORY/$IMAGE_NAME:$IMAGE_TAG"
