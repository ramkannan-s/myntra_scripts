#! /bin/bash

### Exit the script on any failures
set -eo pipefail
set -e
set -u

imageslist="dockerhub_images_list.txt"

#docker login myntra.dockerhub.com -u <username> -p password

while IFS= read -r image_name; do
   # docker pull myntra.dockerhub.com/"$image_name"
    docker tag myntra.dockerhub.com/"$image_name" artifactory.myntra.com/"$image_name":latest
done < $imageslist


docker login artifactory.myntra.com -u <username> -p password

while IFS= read -r image_name; do
    docker push artifactory.myntra.com/"$image_name":latest
done < $imageslist