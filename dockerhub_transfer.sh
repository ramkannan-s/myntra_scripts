#! /bin/bash

### Exit the script on any failures
set -eo pipefail
set -e
set -u

imageslist="dockerhub_images_list.txt"

#docker login dockerhub.myntra.com:5000 -u <username> -p <password>

while IFS= read -r image_name; do
   # docker pull dockerhub.myntra.com:5000/$image_name
   echo -e "\nImage Name Tagging ==> $image_name"
   docker tag dockerhub.myntra.com:5000/$image_name artifactory-ci.myntra.com/dockerhub/$image_name
done < $imageslist


docker login artifactory-ci.myntra.com -u admin -p @Myntra12

while IFS= read -r image_name; do
    echo -e "\nPush Image ==> $image_name"
    docker push artifactory-ci.myntra.com/dockerhub/$image_name
done < $imageslist
