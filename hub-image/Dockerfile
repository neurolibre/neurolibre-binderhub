FROM jupyterhub/k8s-hub:0.11.1-n128.h35ca170e

USER root

# git-annex for datalad and docker
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
#	sudo \
        apt-transport-https \
        ca-certificates \
        lsb-release \
        apt-utils=2.0.5 \
        gnupg=2.2.19-3ubuntu2.1 \
        openssh-server=1:8.2p1-4ubuntu0.2 \
        git=1:2.25.1-1ubuntu3.1 \
        curl=7.68.0-1ubuntu2.5 && \
    #git-annex for Datalad following neuro.debian.net/ and github.com/jacobalberty/unifi-docker/issues/64
    curl http://neuro.debian.net/lists/buster.us-nh.full -o- | tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkp://ipv4.pool.sks-keyservers.net:80 0xA5D32F012649A5A9 && \
    #docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y --no-install-recommends git-annex-standalone docker-ce docker-ce-cli containerd.io && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN usermod -aG docker jovyan
#RUN echo "jovyan:jovyan" | chpasswd && adduser jovyan sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER jovyan
RUN newgrp docker
# add bin path from pip
ENV PATH="/home/jovyan/.local/bin:${PATH}"

RUN mkdir /srv/jupyterhub/data

# install repo2data and scientific database grabbers
RUN python3 -m pip install --upgrade pip && python3 -m pip install --user --no-cache \ 
    repo2data==2.4.2 \
    scipy==1.5.1 \
    GitPython==3.1.11 \
    scikit-learn==0.23.1 \
    nilearn==0.7.1 \
    docker==5.0.0
