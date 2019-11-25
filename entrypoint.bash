#!/bin/bash
set -e

sudo su
ls -ahl /tmp/.ssh
cp -R /tmp/.ssh /home/ubuntu/.ssh

cd /neurolibre-binderhub/
git-crypt unlock /home/ubuntu/.ssh/gitcrypt-key
source /home/ubuntu/neurolibre-binderhub/terraform/keys_cc.sh
source /home/ubuntu/neurolibre-binderhub/terraform/rpp-aevans-ab-openrc.sh

cd /terraform-artifacts
if [ ! -f "/terraform-artifacts/main.tf" ]; then
    echo "You need to specify a terraform main.tf"
    read -p "Press enter to continue"
    cp /neurolibre-binderhub/terraform/main.tf /terraform-artifacts/main.tf
    nano /terraform-artifacts/main.tf
fi

exec "$@"
