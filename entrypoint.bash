#!/bin/bash
set -e

cp -R /tmp/.ssh /root/

cd /neurolibre-binderhub/
git-crypt unlock /root/.ssh/gitcrypt-key
source /neurolibre-binderhub/terraform/keys_cc.sh
source /neurolibre-binderhub/terraform/rpp-aevans-ab-openrc.sh

cd /terraform-artifacts
if [ ! -f "/terraform-artifacts/main.tf" ]; then
    echo "You need to specify a terraform main.tf"
    read -p "Press enter to continue"
    cp /neurolibre-binderhub/terraform/main.tf /terraform-artifacts/main.tf
    nano /terraform-artifacts/main.tf
fi

exec "$@"
