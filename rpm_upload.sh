#! /bin/bash

### Exit the script on any failures
set -eo pipefail
set -e
set -u

rpmslistfile="rpms_list.txt"


#az login

#az storage blob download -c rpmdata -n libxls-1.6.2-7.fc37.i686.rpm -f /Users/ramkannans/git_repos/node-hello/package/libxls-1.6.2-7.fc37.i686.rpm --account-name myntrablobsample

while IFS= read -r rpm_name; do
    curl -u admin:**** -XPUT https://artifactory.myntra.com/artifactory/myntra-rpm-local-1/java/$rpm_name -T $rpm_name
done < $rpmslistfile




