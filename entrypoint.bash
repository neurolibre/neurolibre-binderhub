#!/bin/bash
set -e

cp -R /tmp/.ssh /root/

# openstack and arbutus credentials
source /terraform-artifacts/keys_cc.sh
source /terraform-artifacts/*openrc.sh

cd /terraform-artifacts
if [ ! -f "/terraform-artifacts/main.tf" ]; then
    echo "You need to specify a terraform main.tf"
    read -p "Press enter to continue"
    cp /neurolibre-binderhub/terraform/main.tf /terraform-artifacts/main.tf
    nano /terraform-artifacts/main.tf
fi

touch logs

eval `ssh-agent -s`
ssh-add /root/.ssh/id_rsa

exec "$@"
