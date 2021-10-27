FROM jupyterhub/k8s-hub:1.1.3-n141.h28efde1b

USER root

# git-annex for datalad and docker
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        lsb-release \
        apt-utils \
        gnupg \
        openssh-server \
        git \
        wget \
        curl && \
    #git-annex for Datalad following neuro.debian.net/ and github.com/jacobalberty/unifi-docker/issues/64
    wget -O- http://neuro.debian.net/lists/focal.us-nh.full | tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com 0xA5D32F012649A5A9 && \
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
    repo2data==2.4.4 \
    scipy==1.5.1 \
    GitPython==3.1.11 \
    scikit-learn==0.23.1 \
    nilearn==0.7.1 \
    docker==5.0.0
