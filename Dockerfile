FROM ubuntu:18.04

LABEL maintainer="Loic Tetrel <loic.tetrel.pro@gmail.com>"

USER root

RUN mkdir -p /terraform-artifacts; \
    mkdir -p /root/.ssh

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        apt-utils && \
    apt-get install -y --no-install-recommends \
        sudo \
        ca-certificates \
        openssh-server \
        git \
	unzip \
        wget \
        nano && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/neurolibre/neurolibre-binderhub /neurolibre-binderhub/

RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN wget https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip;\
    unzip ./terraform_0.11.0_linux_amd64.zip -d /usr/local/bin/;\
    rm ./terraform_0.11.0_linux_amd64.zip

COPY ./entrypoint.bash /

ENTRYPOINT ["/bin/bash", "/entrypoint.bash"]
CMD ["/bin/sh", "-c", "rm -rf .terraform && rm -f terraform.* && terraform init && terraform plan && terraform apply | tee logs"]
