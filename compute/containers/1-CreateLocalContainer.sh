# 2.1 Build Docker image

docker build -t fastapi-image:v1 .

# Run and test the Docker locally to test it out
docker run -p 80:80 -it fastapi-image:v1

# Verify the output 
curl http://localhost:80

# If you already built the image you ll need to delete the image and your build cache so new layers are built 
# docker rmi fastapi-image:v1 && docker builder prune --force && docker image prune --force

# Delete the runnign container 
docker stop fastapi-image:v1 
docker rm fastapi-image:v1

