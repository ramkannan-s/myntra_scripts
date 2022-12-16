#! /bin/bash

### Exit the script on any failures
set -eo pipefail
set -e
set -u

npmfileslist="npm_tgz_files_list.txt"
registry_url="https://artifactory.myntra.com/artifactory/api/npm/npm-sample-1/"

while IFS= read -r tgz_file; do
    cp <source_path>/"$tgz_file" /tmp/datatransfer/
    tar -zxvf "$tgz_file"
    cd package/
    npm publish --registry "$registry_url"
    cd .. 
    rm -rf package "$tgz_file"
done < $npmfileslist
