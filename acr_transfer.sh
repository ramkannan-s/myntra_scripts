#! /bin/bash

### Exit the script on any failures
set -eo pipefail
set -e
set -u


docker login myntratestacr.azurecr.io -u myntratestacr -p ****

az acr repository list -n myntratestacr > imageslist.txt

while IFS= read -r image_name; do
    docker pull myntratestacr.azurecr.io/$image_name
    docker tag myntratestacr.azurecr.io/$image_name  myntra.artifactory.com/slipway/$image_name
    docker push myntra.artifactory.com/slipway/$image_name
done < "imageslist.txt"
