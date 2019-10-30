<img align="left" src="https://conp-pcno.github.io/images/neurolibre-icon-red.png"> NeuroLibre is a curated repository of interactive neuroscience notebooks, seamlessly integrating data, text, code and figures. Notebooks can be freely modified and re-executed through the web, offering a fully reproducible, “libre” path from data to figures. NeuroLibre is powered by the Binder project with computational resources provided by [CONP](http://conp.ca/), [CBRAIN](http://mcin.ca/technology/cbrain/), and [Compute Canada](https://www.computecanada.ca/). This repository contains some important documentation and scripts for the developer of the neurolibre platform.
 
# neurolibre-binderhub
Repository that contains all files to set up the binder instance

## binderhub

All files to configure the binder instance including :
`config.yaml` which is the basic configuration file for the binderhub
`templates` and `static` folders containing the template for the binder login page (in dev)
`install-binderhub.sh` to setup up the instance

## hub-image

This docker image is used by binderhub when building a user pod. This is basically used to allow the user to upload his data on the server, using repo2data.

The images are stored in https://hub.docker.com/u/conpdev

## terraform

This folder contains all the terraform configuration to set up the binderhub infrastructure.

## usefull kube commands

https://github.com/kubernetes/kubernetes/issues/17512

Get all kube namespaces

`kubectl get namespace`

List all available nodes

`kubectl get nodes | grep node | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo   {} ; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\''`

Check CPU usage

`util | grep % | awk '{print \$1}' | awk '{ sum += \$1 } END { if (NR > 0) { result=(sum**4000); printf result/NR \"%\n\" } }'`

Check memory usage

`util | grep % | awk '\''{print $3}'\'' | awk '\''{ sum += $1 } END { if (NR > 0) { result=(sum*100)/(NR*1600); printf result/NR "%\n" } }'\''`

Execute a command inside a pod

`kubectl exec -A -it myPod -- /bin/bash`

Delete a pod

`kubectl delete -A pod`

Upgrade the binderhub version

`sudo helm upgrade binderhub jupyterhub/binderhub --version=v0.2.0-10ac4d8 -f config.yaml -f secrets.yaml`

Get all logs from a pod

`kubectl logs -A`

Describe a pod

`kubectl describe pods -A`

List all pods

`paste <(kubectl get pods -n=binderhub) <(kubectl get pod -o=custom-columns=NODE:.spec.nodeName,START:.metadata.creationTimestamp -n=binderhub) | column -s $'\t' -t`

