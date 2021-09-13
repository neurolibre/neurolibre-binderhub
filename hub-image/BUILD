#!/bin/bash

echo "Building hub-image v"$1
sudo docker build --no-cache --tag=conpdev/hub-image:v$1 .
sudo docker tag conpdev/hub-image:v$1 binder-registry.conp.cloud/hub-image:v$1
sudo docker push conpdev/hub-image:v$1
sudo docker push binder-registry.conp.cloud/hub-image:v$1
