FROM ubuntu:18.04

LABEL maintainer="Loic Tetrel <loic.tetrel.pro@gmail.com>"

USER root

RUN apt-get update && \
      apt-get -y install sudo

RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /terraform-artifacts

RUN apt-get install -y --no-install-recommends \
        apt-utils && \
    apt-get install -y --no-install-recommends \
        sudo \
        ca-certificates \
        openssh-server \
        git-crypt \
        unzip \
        wget \
        nano && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip;\
    unzip ./terraform_0.11.0_linux_amd64.zip -d /usr/local/bin/;\
    rm ./terraform_0.11.0_linux_amd64.zip

RUN git clone https://github.com/neurolibre/neurolibre-binderhub /neurolibre-binderhub/

COPY ./entrypoint.bash /

USER ubuntu

WORKDIR /home/ubuntu/

RUN mkdir -p .ssh

ENTRYPOINT ["/bin/bash", "/entrypoint.bash"]
CMD ["sh", "-c", "terraform init && terraform plan && terraform apply"]
